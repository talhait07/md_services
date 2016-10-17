class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid, default: 'uuid_generate_v1mc()' do |t|
      t.string   :email,                           :null => false
      t.string   :first_name,                      :null => false
      t.string   :last_name,                       :null => false
      t.string   :crypted_password
      t.string   :salt
      t.string   :reset_password_token,            :default => nil
      t.datetime :reset_password_token_expires_at, :default => nil
      t.datetime :reset_password_email_sent_at,    :default => nil
      t.boolean  :god,                             :default => false


      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token
  end
end
