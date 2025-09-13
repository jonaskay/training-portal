class OrganizationCredential < ApplicationRecord
  has_secure_password

  validates :title, presence: true
  validates :username, presence: true, uniqueness: true
end
