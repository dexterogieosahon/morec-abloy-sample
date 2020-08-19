# frozen_string_literal: true

# Recommendation backend
class RecommendEngine

  # Provides movie recommendation with external services
  # @param genre [String] (required)
  # @return [Hash]
  def self.recommend(genre)
    movies = {
      comedy: [
        {
          popularity: 149.921,
          vote_count: 2893,
          video: false,
          poster_path: "/mb7wQv0adK3kjOUr9n93mANHhPJ.jpg",
          id: 583083,
          adult: false,
          backdrop_path: "/wO5QSWZPBT71gMLvrRex0bVc0V9.jpg",
          original_language: "en",
          original_title: "The Kissing Booth 2",
          genre_ids: [
            35,
            10749
          ],
          title: "The Kissing Booth 2",
          vote_average: 8.2,
          overview: "With college decisions looming, Elle juggles her long-distance romance with Noah, changing relationship with bestie Lee and feelings for a new classmate.",
          release_date: "2020-07-24"
        }
      ],
      action: [
        {
          popularity: 123.88,
          vote_count: 123,
          video: false,
          poster_path: "/bKthjUmxjHjvJK8FktFfQdmwP12.jpg",
          id: 703745,
          adult: false,
          backdrop_path: "/hIHtyIYgBqHybOgUdoAmveipuiO.jpg",
          original_language: "en",
          original_title: "Deep Blue Sea 3",
          genre_ids: [
            28,
            27,
            878
          ],
          title: "Deep Blue Sea 3",
          vote_average: 6.7,
          overview: "Dr. Emma Collins and her team are spending their third summer on the island of Little Happy studying the effect of climate change on the great white sharks who come to the nearby nursery every year to give birth. Along with the last two inhabitants of this former fishing village, their peaceful life is disrupted when a \"scientific\" team led by her ex-boyfriend and marine biologist Richard show up looking for three bull sharks who we soon learn aren't just any bull sharks.",
          release_date: "2020-07-28"
        }
      ],
      animated: [
        {
          popularity: 132.949,
          vote_count: 41,
          video: false,
          poster_path: "/vFIHbiy55smzi50RmF8LQjmpGcx.jpg",
          id: 703771,
          adult: false,
          backdrop_path: "/owraiceOKtSOa3t8sp3wA9K2Ox6.jpg",
          original_language: "en",
          original_title: "Deathstroke: Knights & Dragons - The Movie",
          genre_ids: [
            28,
            16
          ],
          title: "Deathstroke: Knights & Dragons - The Movie",
          vote_average: 7.5,
          overview: "Ten years ago, Slade Wilson-aka the super-assassin called Deathstroke-made a tragic mistake and his wife and son paid a terrible price. Now, a decade later, Wilson's family is threatened once again by the murderous Jackal and the terrorists of H.IV.E. Can Deathstroke atone for the sins of the past-or will his family pay the ultimate price?",
          release_date: "2020-08-04"
        }
      ],
      horror: [
        {
          popularity: 123.88,
          vote_count: 123,
          video: false,
          poster_path: "/bKthjUmxjHjvJK8FktFfQdmwP12.jpg",
          id: 703745,
          adult: false,
          backdrop_path: "/hIHtyIYgBqHybOgUdoAmveipuiO.jpg",
          original_language: "en",
          original_title: "Deep Blue Sea 3",
          genre_ids: [
            28,
            27,
            878
          ],
          title: "Deep Blue Sea 3",
          vote_average: 6.7,
          overview: "Dr. Emma Collins and her team are spending their third summer on the island of Little Happy studying the effect of climate change on the great white sharks who come to the nearby nursery every year to give birth. Along with the last two inhabitants of this former fishing village, their peaceful life is disrupted when a \"scientific\" team led by her ex-boyfriend and marine biologist Richard show up looking for three bull sharks who we soon learn aren't just any bull sharks.",
          release_date: "2020-07-28"
        }
      ],
      romance: [
        {
          popularity: 149.921,
          vote_count: 2893,
          video: false,
          poster_path: "/mb7wQv0adK3kjOUr9n93mANHhPJ.jpg",
          id: 583083,
          adult: false,
          backdrop_path: "/wO5QSWZPBT71gMLvrRex0bVc0V9.jpg",
          original_language: "en",
          original_title: "The Kissing Booth 2",
          genre_ids: [
            35,
            10749
          ],
          title: "The Kissing Booth 2",
          vote_average: 8.2,
          overview: "With college decisions looming, Elle juggles her long-distance romance with Noah, changing relationship with bestie Lee and feelings for a new classmate.",
          release_date: "2020-07-24"
        }
      ]
    }
    movies.fetch(genre.to_sym, [])
  end

end
