class SearchResultSerializer
  include JSONAPI::Serializer
  attributes  :id,
              :title,
              :type,
              :release_year,
              :runtime,
              :language,
              :imdb_id,
              :tmdb_id,
              :tmdb_type
end
