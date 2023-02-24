class UserSerializer 
  include JSONAPI::Serializer 
  attributes :uid, :username, :email, :full_name, :image
end