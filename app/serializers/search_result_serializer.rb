class SearchResultSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :media_type, :release_year, :tmdb_id, :tmdb_type, :poster, :user_lists, :added_to_list_on, :user_rating
end
