class DashboardTest < ActionDispatch::IntegrationTest
include Capybara::DSL

  def setup
    Capybara.app = Shithub::Application
    stub_omniauth
  end

  def test_it_logs_in
    VCR.use_cassette("brett") do
      visit '/'
      click_on 'Github Login'
      assert page.has_content?("brettgrigsby")
    end
  end

  def test_it_displays_follow_stats
    VCR.use_cassette("brett") do
      visit '/'
      click_on 'Github Login'
      assert page.has_content?("Followers: 4")
      assert page.has_content?("Following: 2")
    end
  end

  def test_it_displays_social_stats
    VCR.use_cassette("brett") do
      visit '/'
      click_on 'Github Login'
      assert page.has_content?("Starred Repos: 1")
      assert page.has_content?("RubyRightBack")
    end
  end

  def test_it_displays_event_feed
    VCR.use_cassette("brett") do
      visit '/'
      click_on 'Github Login'
      assert page.has_content?("Push")
    end
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
        provider: 'github',
        extra: {
          raw_info: {
            user_id: "8657755",
            name: "brettgrigsby",
          }
        },
        credentials: {
          token: ENV["github_sample_token"],
        },
        info: {
          image: "https://avatars.githubusercontent.com/u/8657755?v=3",
          nickname: "brettgrigsby"
        }
      })
  end
end
