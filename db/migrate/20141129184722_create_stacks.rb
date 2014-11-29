class CreateStacks < ActiveRecord::Migration
  def change
    create_table :stacks do |t|
      t.references :account, null: false
      t.references :article, null: false

      t.timestamps
    end

    add_index :stacks, [ :account_id, :article_id ], unique: true
    add_foreign_key :stacks, :accounts
    add_foreign_key :stacks, :articles
  end
end
