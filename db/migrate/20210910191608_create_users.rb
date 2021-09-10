class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false
      t.string :password, null: false
      t.string :first_name
      t.string :last_name
      t.string :salt, null: false
      t.boolean :deleted, :default => false

      t.timestamps
    end
  end
end
