module AuthenticationTestHelper
  def visit_sign_in_page
    visit new_session_path
    assert_title "Sign in"
  end

  def visit_forgot_password_page
    visit new_password_path
    assert_title "Forgot your password?"
  end

  def visit_reset_password_page(token)
    visit edit_password_path(token)
  end

  def fill_in_user_email_address_with(email_address)
    fill_in "email_address", with: email_address
  end

  def fill_in_user_password_with(password)
    fill_in "password", with: password
  end

  def fill_in_user_password_confirmation_with(password)
    fill_in "password_confirmation", with: password
  end

  def click_sign_in_link
    click_on "Sign In"
  end

  def click_sign_in_button
    click_button "Sign in"
  end

  def click_sign_out_button
    click_button "Sign Out"
  end

  def click_forgot_password_link
    click_on "Forgot password?"
  end

  def click_reset_password_button
    click_on "Email reset instructions"
  end

  def click_password_update_button
    click_button "Save"
  end

  def assert_root_page
    assert_current_path root_path
    assert_title "Training Portal"
  end

  def assert_sign_in_page
    assert_title "Sign in"
  end

  def assert_forgot_password_page
    assert_current_path new_password_path
    assert_title "Forgot your password?"
  end

  def assert_reset_password_page
    assert_title "Update your password"
  end

  def assert_sign_in_link
    assert_link "Sign In"
  end

  def assert_no_sign_in_link
    assert_no_link "Sign In"
  end

  def assert_sign_out_button
    assert_button "Sign Out"
  end

  def assert_no_sign_out_button
    assert_no_button "Sign Out"
  end

  def assert_sign_in_alert
    assert_selector "#alert", text: "Try another email address or password."
  end

  def assert_reset_password_notice
    assert_selector "#notice", text: "Password reset instructions sent (if user with that email address exists)."
  end

  def assert_reset_token_alert
    assert_selector "#alert", text: "Password reset link is invalid or has expired."
  end

  def assert_password_update_notice
    assert_selector "#notice", text: "Password has been reset."
  end

  def assert_password_update_alert
    assert_selector "#alert", text: "Passwords did not match."
  end
end
