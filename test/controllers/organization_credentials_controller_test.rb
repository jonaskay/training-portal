require "test_helper"

class OrganizationCredentialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization_credential = organization_credentials(:acme_corp)
    @user = users(:one)
    @session = @user.sessions.create!(user_agent: "test", ip_address: "127.0.0.1")
  end

  private

  def sign_in_as(user)
    session = user.sessions.create!(user_agent: "test", ip_address: "127.0.0.1")
    post session_url, params: { email_address: user.email_address, password: "password" }
  end

  def sign_out
    delete session_url
  end

  test "should require authentication for index" do
    sign_out
    get organization_credentials_url
    assert_redirected_to new_session_path
  end

  test "should get index" do
    sign_in_as(@user)
    get organization_credentials_url
    assert_response :success
  end

  test "should require authentication for new" do
    sign_out
    get new_organization_credential_url
    assert_redirected_to new_session_path
  end

  test "should get new" do
    sign_in_as(@user)
    get new_organization_credential_url
    assert_response :success
  end

  test "should require authentication for create" do
    sign_out
    post organization_credentials_url, params: { organization_credential: { title: "Test", username: "test", password: "password" } }
    assert_redirected_to new_session_path
  end

  test "should create organization_credential" do
    sign_in_as(@user)
    assert_difference("OrganizationCredential.count") do
      post organization_credentials_url, params: { organization_credential: { title: "New Test Org", username: "newtest", password: "password123", password_confirmation: "password123" } }
    end

    assert_redirected_to organization_credential_url(OrganizationCredential.last)
  end

  test "should not create organization_credential with invalid data" do
    sign_in_as(@user)
    assert_no_difference("OrganizationCredential.count") do
      post organization_credentials_url, params: { organization_credential: { title: "", username: "", password: "" } }
    end

    assert_response :unprocessable_entity
  end

  test "should require authentication for show" do
    sign_out
    get organization_credential_url(@organization_credential)
    assert_redirected_to new_session_path
  end

  test "should show organization_credential" do
    sign_in_as(@user)
    get organization_credential_url(@organization_credential)
    assert_response :success
  end

  test "should require authentication for edit" do
    sign_out
    get edit_organization_credential_url(@organization_credential)
    assert_redirected_to new_session_path
  end

  test "should get edit" do
    sign_in_as(@user)
    get edit_organization_credential_url(@organization_credential)
    assert_response :success
  end

  test "should require authentication for update" do
    sign_out
    patch organization_credential_url(@organization_credential), params: { organization_credential: { title: "Updated" } }
    assert_redirected_to new_session_path
  end

  test "should update organization_credential" do
    sign_in_as(@user)
    patch organization_credential_url(@organization_credential), params: { organization_credential: { title: "Updated ACME Corp", username: "updatedacme", password: "newpassword123", password_confirmation: "newpassword123" } }
    assert_redirected_to organization_credential_url(@organization_credential)
  end

  test "should not update organization_credential with invalid data" do
    sign_in_as(@user)
    patch organization_credential_url(@organization_credential), params: { organization_credential: { title: "", username: "" } }
    assert_response :unprocessable_entity
  end

  test "should require authentication for destroy" do
    sign_out
    delete organization_credential_url(@organization_credential)
    assert_redirected_to new_session_path
  end

  test "should destroy organization_credential" do
    sign_in_as(@user)
    assert_difference("OrganizationCredential.count", -1) do
      delete organization_credential_url(@organization_credential)
    end

    assert_redirected_to organization_credentials_url
  end
end
