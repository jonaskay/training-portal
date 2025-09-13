require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase
  test "visiting the home page" do
    visit root_path

    assert_selector "h1", text: "Welcome to Training Portal"
  end

  test "visiting the about page renders markdown" do
    visit about_path

    assert_selector "h1", text: "About Our Company"
    assert_selector "h2", text: "Our Mission"
    assert_selector "h3", text: "Markdown Support"
    assert_selector "strong", text: "training portal"
    assert_selector "code"
    assert_text "def hello_world"
    assert_text "Current time is"
    assert_text "Page title from front matter: About Us"
  end
end
