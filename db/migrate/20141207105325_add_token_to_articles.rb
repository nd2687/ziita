class AddTokenToArticles < ActiveRecord::Migration
  def up
    add_column :articles, :access_token, :string, default: ""
    Article.all.each do |article|
      tmp_token = SecureRandom.urlsafe_base64(6)
      article.access_token = tmp_token
      article.save!
    end

    change_column :articles, :access_token, :string, null: false, limit: 8
    add_index :articles, :access_token, unique: true
  end

  def down
    remove_column :articles, :access_token
  end
end
