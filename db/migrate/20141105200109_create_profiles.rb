class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles, id: :uuid, default: 'uuid_generate_v1mc()' do |t|
      t.uuid   :user_id,                         null: false
      t.string :stripe_id,                       null: false
      t.date   :birth_date,                      null: false
      t.string :phone_number,                    null: false

      t.timestamps
    end

    add_index :profiles, :user_id
    add_index :profiles, :stripe_id
  end
end
