require "test_helper"

class OrganizationCredentialTest < ActiveSupport::TestCase
  def setup
    @org_credential = OrganizationCredential.new(
      title: "Test Organization",
      username: "testorg",
      password: "password123"
    )
  end

  test "should be valid with valid attributes" do
    assert @org_credential.valid?
  end

  test "should require title" do
    @org_credential.title = nil
    assert_not @org_credential.valid?
    assert_includes @org_credential.errors[:title], "can't be blank"
  end

  test "should require username" do
    @org_credential.username = nil
    assert_not @org_credential.valid?
    assert_includes @org_credential.errors[:username], "can't be blank"
  end

  test "should require password" do
    @org_credential.password = nil
    assert_not @org_credential.valid?
    assert_includes @org_credential.errors[:password], "can't be blank"
  end

  test "should require unique username" do
    @org_credential.save!

    duplicate_org_credential = OrganizationCredential.new(
      title: "Another Organization",
      username: "testorg",
      password: "password456"
    )

    assert_not duplicate_org_credential.valid?
    assert_includes duplicate_org_credential.errors[:username], "has already been taken"
  end

  test "should save with valid attributes" do
    assert @org_credential.save
  end

  test "should authenticate with correct password" do
    @org_credential.save!
    assert @org_credential.authenticate("password123")
  end

  test "should not authenticate with incorrect password" do
    @org_credential.save!
    assert_not @org_credential.authenticate("wrongpassword")
  end

  test "should have secure password functionality" do
    @org_credential.save!
    assert @org_credential.password_digest.present?
    assert_not_equal "password123", @org_credential.password_digest
  end
end
