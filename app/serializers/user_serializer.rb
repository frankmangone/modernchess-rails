class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email

  def id
    object.url_token
  end
  
end
