class DashboardController < ApplicationController
  def show
    @client = Octokit::Client.new(access_token: current_user.token)
    byebug
  end
end
