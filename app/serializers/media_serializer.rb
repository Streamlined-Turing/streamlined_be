class MediaSerializer
  include JSONAPI::Serializer
  attributes  :id,
              :title,
              :audience_score,
              :rating,
              :type,
              :description,
              :genres,
              :release_year,
              :runtime,
              :language,
              :streaming_services,
              :poster
end
