class CreateAccountImages < ActiveRecord::Migration
  def change
    create_table :account_images do |t|
      t.references :account, null: false
      t.binary :data                       # 画像データ
      t.string :content_type               # MIMEタイプ

      t.timestamps
    end

    add_index :account_images, :account_id
    add_foreign_key :account_images, :accounts
  end
end
