class AddTokenToAccounts < ActiveRecord::Migration
  def up
    add_column :accounts, :account_token, :string, default: ""
    Account.all.each do |account|
      tmp_token = SecureRandom.urlsafe_base64(15)
      account.account_token = tmp_token
      account.save!
    end

    change_column :accounts, :account_token, :string, null: false, limit: 20
    add_index :accounts, :account_token, unique: true
  end

  def down
    remove_column :accounts, :account_token
  end
end
