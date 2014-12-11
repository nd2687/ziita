class AlterArticle < ActiveRecord::Migration
  def change
    add_column :articles, :published, :boolean, null: false, default: true
  end
end
