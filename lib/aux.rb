# frozen_string_literal: true

require 'uri'

# Namespace for auxillary methods
module Aux
  # Validates data against validating schema
  # @param data [Hash] target of validation
  # @param schema [Object] definition with rules
  # @return [Hash] result from DRY-Validation validation
  def self.validate(data, schema)
    schema.call(data)
  end

  # Extracts present instance vars to hash
  # @param obj [Object] whose instance vars to extract
  # @param opts [Hash] additional params
  # @return [Hash] object hash
  def self.to_h(obj, opts = { allow_blank: false, excludes: [], camelize: :lower })
    data = {}
    obj.instance_variables.each do |variable|
      key = variable.to_s.delete('@').underscore
      next unless key
      next if opts[:excludes]&.is_a?(Array) && opts[:excludes]&.include?(key)
      value = obj.instance_variable_get(variable)
      if value.blank?
        next unless opts[:allow_blank]
      end
      camelized = %i[lower upper].include?(opts[:camelize]) ? opts[:camelize] : nil
      if camelized
        data[key.camelize(camelized)] = value
      else
        data[key] = value
      end
    end
    data.symbolize_keys
  end

  # Turns hash options to struct
  # @param opts [Hash] key value pair
  # @return [Struct]
  def self.h2struct(opts)
    ::Struct.new(*opts.keys.map(&:to_sym)).new(*opts.values)
  end

  # applies pagination to dataset
  # @param dataset [Sequel::Postgres::Dataset] dataset without pagination
  # @param opts [Hash]
  # @option opts [Integer] :page requested page
  # @option opts [Integer] :page_size  number of records per page
  # @return [Sequel::Postgres::Dataset] enriched with pagination
  # behaviours such as current_page, next_page, prev_page, total_pages,
  # total_count
  def self.paginate(dataset, opts)
    page_nr   = opts[:page].to_i
    page_nr   = page_nr.positive? ? page_nr : 1
    page_size = opts[:page_size].to_i
    page_size = page_size.positive? && page_size <= 3500 ? page_size : 20

    dataset.paginate(page_nr, page_size)
  end

  # applies pagination to an array
  # @param array [Array] array without pagination
  # @param opts [Hash]
  # @option opts [Integer] :page requested page
  # @option opts [Integer] :page_size  number of records per page
  # @return [Hash] paginated array and metadata
  def self.paginate_array(array, opts)
    page = opts[:page]
    page_size = opts[:page_size]

    if page && page_size
      page = page.to_i
      page_size = page_size.to_i

      start_index = (page - 1) * page_size
      end_index = page * page_size
      paged_array = array[start_index...end_index]

      total_pages = array.count / page_size
      total_pages += 1 if array.count % page_size != 0

      next_page = page >= total_pages ? nil : page + 1
      prev_page = page <= 1 ? nil : page - 1
      page_meta = { pagination: {
        page_size: page_size,
        page: page,
        next_page: next_page,
        prev_page: prev_page,
        total_pages: total_pages,
        total_count: array.count
      } }
      array = paged_array
    else
      page_meta = { pagination: {
        page_size: array.count,
        page: 1,
        next_page: nil,
        prev_page: nil,
        total_pages: 1,
        total_count: array.count
      } }
    end

    { data: array, page_meta: page_meta }
  end

  # Provides pagination info.
  # @param object [Object] that responds to
  # applied methods. mostly Sequel::Dataset
  # @return [Hash] hash wrapped with pagination info
  def self.page_meta(object)
    {
      pagination: {
        page_size: object.page_size,
        page: object.current_page,
        next_page: object.next_page,
        prev_page: object.prev_page,
        total_pages: object.page_count,
        total_count: object.pagination_record_count
      }
    }
  end

  # Encodes a ruby hash into json
  # @param data [Hash] hash to encode
  # @return [String] json string
  def self.h2json(data)
    MultiJson.dump(data)
  end

  # Decodes a json string into ruby hash
  # @param json [String] string to decode
  # @return [Hash, nil] decoded json
  def self.j2hash(json)
    MultiJson.load(json, symbolize_keys: true)
  rescue MultiJson::ParseError => exception
    notify(exception)
    nil
  end

  # Writes data to file
  def self.write(data, dir, filename)
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
    filename = "#{dir}/#{filename}"
    File.open(filename, 'w') { |f| f.write(data) }
  end

  # reads data from file
  # @return [String, NilClass] read file or nil
  def self.read_file(path)
    ::File.read(path)
  rescue StandardError
    nil
  end

end
