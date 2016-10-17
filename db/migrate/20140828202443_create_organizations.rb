class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations, id: :uuid, default: 'uuid_generate_v1mc()' do |t|
      t.string  :stripe_recipient_id              

      t.string  :name,                            :null => false
      t.string  :npi_number,                      :null => false
      t.integer :positions,                       :null => false
      t.string  :address_1,                       :null => false
      t.string  :address_2
      t.string  :city,                            :null => false
      t.string  :state,                           :null => false
      t.string  :postal_code,                     :null => false
      t.string  :phone_number,                    :null => false
      t.string  :url,                             :null => false

      t.integer :sites_count,                     :default => 0
      t.integer :organization_users_count,        :default => 0

      t.timestamps
    end

    add_index :organizations, :stripe_recipient_id
    add_index :organizations, :npi_number
  end
end
