class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites, id: :uuid, default: 'uuid_generate_v1mc()' do |t|
      t.uuid    :organization_id,                 :null => false

      t.string  :name,                            :null => false
      t.string  :address_1,                       :null => false
      t.string  :address_2
      t.string  :city,                            :null => false
      t.string  :state,                           :null => false
      t.string  :postal_code,                     :null => false
      t.string  :phone_number,                    :null => false
      t.string  :site_number,                     :null => false

      t.timestamps
    end

    add_index :sites, :organization_id
    add_index :sites, :site_number
  end
end
