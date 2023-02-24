class UserSerializer 
  include JSONAPI::Serializer 
  attributes :uid, :username, :email, :first_name, :last_name, :image
end