class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients, id: :uuid, default: 'uuid_generate_v1mc()' do |t|
      t.uuid :user_id,        null: false
      t.uuid :site_id,        null: false

      t.timestamps
    end

    add_index :patients, [:user_id, :site_id], unique: true
  end
end
