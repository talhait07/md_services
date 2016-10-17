class CreateEncounters < ActiveRecord::Migration
  def change
    create_table :encounters, id: :uuid, default: 'uuid_generate_v1mc()' do |t|
      t.uuid   :site_id,        null: false
      t.uuid   :patient_id
      t.string :status,         null: false, default: 'open'

      t.string :first_name,     null: false
      t.string :last_name,      null: false
      t.date   :birth_date,     null: false
      t.string :phone_number,   null: false

      t.money  :balance

      t.timestamps
    end

    add_index :encounters, :site_id
    add_index :encounters, :patient_id
  end
end
