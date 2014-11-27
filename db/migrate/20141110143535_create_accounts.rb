class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :identify_name,      null: false
      t.string :email,              null: false
      t.string :email_for_index,    null: false
      t.boolean :email_publication, null: false, default: false
      t.string :password_digest,    null: false
      t.text :self_introduction
      t.string :sites
      t.string :company
      t.string :residence

      t.timestamps
    end

    add_index :accounts, [ :identify_name, :email_for_index ], unique: true
  end
end
