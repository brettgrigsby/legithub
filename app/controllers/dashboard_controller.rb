class DashboardController < ApplicationController
  def show
    @client = Octokit::Client.new(access_token: current_user.token)
    @events = @client.user_events(current_user.nickname)
#    byebug
  end
end
