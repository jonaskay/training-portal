require "test_helper"
require_relative "test_helper/authentication_test_helper"
require_relative "test_helper/jobs_test_helper"
require_relative "test_helper/pages_test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include AuthenticationTestHelper
  include JobsTestHelper
  include PagesTestHelper

  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
end
