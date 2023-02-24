class UserSerializer
  include JSONAPI::Serializer
  attributes :sub, :username, :email, :name, :picture
end
