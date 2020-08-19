# frozen_string_literal: true

require './lib/middlewares/request_timer'
require './lib/middlewares/request_id'
require './lib/middlewares/body_parser'

require './lib/middlewares/exception_handler'
require './lib/middlewares/status_check'

# load libs
Dir['./lib/{[!tasks,middlewares]**/*,*}.rb'].each { |rb| require rb }

# load other app dependencies
(Dir['./app/helpers/**/*.rb'] +
 Dir['./app/models/usecase/base.rb'] +
 Dir['./app/models/**/*.rb'] +
 Dir['./app/validators/base.rb'] +
 Dir['./app/validators/**/*.rb'] +
 Dir['./app/open_api/shared/properties/**/*.rb'] +
 Dir['./app/open_api/types/**/*.rb'] +
 Dir['./app/open_api/shared/**/*.rb'] +
 Dir['./app/controllers/base.rb'] +
 Dir['./app/controllers/main.rb'] +
 Dir['./app/controllers/**/*.rb']
).uniq.each { |rb| require rb }
