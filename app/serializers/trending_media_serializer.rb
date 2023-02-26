class TrendingMediaSerializer 
  include JSONAPI::Serializer 

  attributes :id,
             :title,
             :poster_path,
             :media_type,
             :vote_average
end