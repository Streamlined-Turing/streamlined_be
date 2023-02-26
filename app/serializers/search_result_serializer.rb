class SearchResultSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :media_type, :release_year, :tmdb_id, :tmdb_type, :poster
end
