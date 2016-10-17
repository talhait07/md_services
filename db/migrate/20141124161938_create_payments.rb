class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments, id: :uuid, default: 'uuid_generate_v1mc()' do |t|
      t.uuid   :encounter_id,                   null: false
      t.string :charge_id

      t.string :status,                         null: false, default: 'pending'
      t.money  :amount

      t.timestamps
    end

    add_index :payments, :encounter_id
  end
end
