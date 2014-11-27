class CreateAccountIdentities < ActiveRecord::Migration
  def change
    create_table :account_identities do |t|
      t.references :account, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :email, null: false
      t.string :nickname, null: false

      t.timestamps
    end

    add_index :account_identities, [ :provider, :uid, :email ], unique: true
    add_index :account_identities, [ :provider, :uid, :nickname ], unique: true
  end
end
