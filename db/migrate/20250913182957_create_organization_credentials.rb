class CreateOrganizationCredentials < ActiveRecord::Migration[8.0]
  def change
    create_table :organization_credentials do |t|
      t.string :title, null: false
      t.string :username, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
    add_index :organization_credentials, :username, unique: true
  end
end
