class MediaSerializer
  include JSONAPI::Serializer
  attributes  :id,
              :title,
              :audience_score,
              :rating,
              :media_type,
              :description,
              :genres,
              :release_year,
              :runtime,
              :language,
              :sub_services,
              :poster,
              :imdb_id,
              :tmdb_id,
              :tmdb_type,
              :trailer
end
