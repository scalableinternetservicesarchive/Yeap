class CreateUserActiveRecords < ActiveRecord::Migration
  def change
    create_table :user_active_records do |t|

      t.timestamps null: false
    end
  end
end
