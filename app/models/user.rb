class User < ActiveRecord::Base
  def self.find_or_create_from_oauth(oauth)
    user = User.find_or_create_by(provider: oauth.provider, uid: oauth.uid)
    user.name      = oauth.info.name
    user.email     = oauth.info.email
    user.nickname  = oauth.info.nickname
    user.image     = oauth.info.image
    user.token     = oauth.credentials.token
    user.save
    user
  end
end
