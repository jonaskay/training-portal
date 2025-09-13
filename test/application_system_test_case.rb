require "test_helper"
require_relative "support/authentication_test_helper"
require_relative "support/jobs_test_helper"
require_relative "support/pages_test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include AuthenticationTestHelper
  include JobsTestHelper
  include PagesTestHelper

  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
end
