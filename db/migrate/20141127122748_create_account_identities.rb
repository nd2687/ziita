class CreateAccountIdentities < ActiveRecord::Migration
  def change
    create_table :account_identities do |t|
      t.references :account, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :info, null: false

      t.timestamps
    end

    add_index :account_identities, [ :provider, :uid, :info ], unique: true
  end
end
