class AddUserNameToComment < ActiveRecord::Migration
  def change
    add_column :comments, :user_name, :string, null: false
  end
end
