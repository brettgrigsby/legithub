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

  def github_client
    @client = Octokit::Client.new(access_token: token)
  end

#  def last_year_commits
#   github_client.commits_between
#  end

  def following_feed
    events = github_client.following.map do |user|
      github_client.user_events(user.login)
    end.flatten
    events.sort_by { |event| event.created_at }.reverse
  end
end
