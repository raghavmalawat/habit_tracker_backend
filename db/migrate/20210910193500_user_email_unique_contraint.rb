class UserEmailUniqueContraint < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    enable_extension("citext")
    change_column :users, :email, :citext

    add_index :users, :email, unique: true, algorithm: :concurrently
  end
end
