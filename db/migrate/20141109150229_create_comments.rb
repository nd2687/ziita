class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :article, null: false
      t.string :name
      t.text :body, null: false

      t.timestamps
    end

    add_index :comments, :article_id
    add_foreign_key :comments, :articles
  end
end
