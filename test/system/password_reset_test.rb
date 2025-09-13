require "application_system_test_case"

class PasswordResetTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    ActionMailer::Base.deliveries.clear
  end

  test "user can request password reset with valid email" do
    visit_sign_in_page

    click_forgot_password_link

    assert_forgot_password_page

    fill_in_user_email_address_with @user.email_address

    assert_job_enqueued do
      click_reset_password_button

      assert_sign_in_page
      assert_reset_password_notice
    end
  end

  test "password reset request with non-existent email shows success message" do
    visit_forgot_password_page

    fill_in_user_email_address_with "nonexistent@example.com"

    assert_job_not_enqueued do
      click_reset_password_button

      assert_sign_in_page
      assert_reset_password_notice
    end
  end

  test "user can reset password with valid token" do
    visit_reset_password_page(@user.password_reset_token)

    fill_in_user_password_with "newpassword"
    fill_in_user_password_confirmation_with "newpassword"
    click_password_update_button

    assert_sign_in_page
    assert_password_update_notice

    fill_in_user_email_address_with @user.email_address
    fill_in_user_password_with "newpassword"
    click_sign_in_button

    assert_root_page
    assert_sign_out_button
  end

  test "password reset with mismatched passwords shows error" do
    visit_reset_password_page(@user.password_reset_token)

    fill_in_user_password_with "newpassword"
    fill_in_user_password_confirmation_with "differentpassword"
    click_password_update_button

    assert_reset_password_page
    assert_password_update_alert
  end

  test "password reset with invalid token shows error" do
    visit_reset_password_page("invalid-token")

    assert_forgot_password_page
    assert_reset_token_alert
  end
end
