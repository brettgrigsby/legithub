class DashboardController < ApplicationController
  helper_method :commit_link
  def show
    @client = Octokit::Client.new(access_token: current_user.token)
    @events = @client.user_events(current_user.nickname)
#    byebug
  end

  def commit_link(event)
    if event.payload.commits
      "http://github.com/#{event.repo.name}/commits/#{event.payload.commits.first.sha}"
    else
      "http://github.com/#{event.repo.name}"
    end
  end
end
