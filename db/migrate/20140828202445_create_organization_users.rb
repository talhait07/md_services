class CreateOrganizationUsers < ActiveRecord::Migration
  def change
    create_table :organization_users, id: :uuid, default: 'uuid_generate_v1mc()' do |t|
      t.hstore :roles
      t.uuid   :organization_id,     :null => false
      t.uuid   :user_id,             :null => false
      t.string :status,              :null => false, :default => 'active'

      t.timestamps
    end

    add_index :organization_users, [:organization_id, :user_id], unique: true
  end
end
