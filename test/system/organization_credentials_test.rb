require "application_system_test_case"

class OrganizationCredentialsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @organization_credential = organization_credentials(:acme_corp)
    sign_in_user
  end

  def sign_in_user
    visit new_session_path
    fill_in_user_email_address_with @user.email_address
    fill_in_user_password_with "password"
    click_sign_in_button
    assert_current_path root_path
    assert_button "Sign Out"
  end

  test "visiting the index" do
    visit root_path
    click_on "Organization Credentials"
    assert_selector "h1", text: "Organization Credentials"
  end

  test "creating a organization credential" do
    visit organization_credentials_url
    click_on "New Organization Credential"

    fill_in "Title", with: "Test Organization"
    fill_in "Username", with: "testorg"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    click_on "Create Organization credential"

    assert_text "Organization credential was successfully created"
    assert_current_path organization_credential_path(OrganizationCredential.last)
  end

  test "updating a organization credential" do
    visit organization_credential_url(@organization_credential)
    click_on "Edit"

    fill_in "Title", with: "Updated ACME Corporation"
    fill_in "Username", with: "updatedacme"
    fill_in "Password", with: "newpassword123"
    fill_in "Password confirmation", with: "newpassword123"
    click_on "Update Organization credential"

    assert_text "Organization credential was successfully updated"
    assert_current_path organization_credential_path(@organization_credential)
  end

  test "destroying a organization credential" do
    visit organization_credential_url(@organization_credential)

    accept_confirm do
      click_on "Delete"
    end

    assert_text "Organization credential was successfully deleted"
    assert_current_path organization_credentials_path
  end

  test "showing validation errors" do
    visit organization_credentials_url
    click_on "New Organization Credential"

    click_on "Create Organization credential"

    assert_text "prohibited this organization credential from being saved"
  end

  test "shows organization credential details" do
    visit organization_credential_url(@organization_credential)
    assert_text @organization_credential.title
    assert_text @organization_credential.username
    assert_no_text @organization_credential.password_digest
  end
end
