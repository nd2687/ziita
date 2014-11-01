class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.string :login_name, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
