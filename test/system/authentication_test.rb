require "application_system_test_case"

class AuthenticationTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "user can sign in with valid credentials" do
    visit_root_path

    click_sign_in_link

    assert_sign_in_page

    fill_in_user_email_address_with @user.email_address
    fill_in_user_password_with "password"
    click_sign_in_button

    assert_root_page
    assert_sign_out_button
    assert_no_sign_in_link
  end

  test "user cannot sign in with invalid credentials" do
    visit_sign_in_page

    fill_in_user_email_address_with @user.email_address
    fill_in_user_password_with "wrongpassword"
    click_sign_in_button

    assert_sign_in_alert
    assert_no_sign_out_button
  end

  test "user cannot sign in with non-existent email" do
    visit_sign_in_page

    fill_in_user_email_address_with "nonexistent@example.com"

    fill_in_user_password_with "password"
    click_sign_in_button

    assert_sign_in_alert
  end

  test "authenticated user can sign out" do
    visit_sign_in_page
    fill_in_user_email_address_with @user.email_address
    fill_in_user_password_with "password"
    click_sign_in_button

    click_sign_out_button

    assert_sign_in_page
    assert_sign_in_link
    assert_no_sign_out_button
  end
end
