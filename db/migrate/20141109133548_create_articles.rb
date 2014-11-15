class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :account, null: false
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps
    end

    add_index :articles, :account_id
  end
end
