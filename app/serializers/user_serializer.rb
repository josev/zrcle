class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :email, :password, :provider, :uid, :oauth_token, :image,
  :profile

  def profile
  	Profile.select("id, country, description").where(user_id: object.id).first
  end
end
