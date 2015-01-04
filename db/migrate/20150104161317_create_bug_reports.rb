class CreateBugReports < ActiveRecord::Migration
  def change
    create_table :bug_reports do |t|
      t.string :title,        null: false
      t.string :body,         null: false
      t.boolean :completable, null: false, default: false

      t.timestamps null: false
    end
  end
end
