class CreateLike < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      
      t.references :user, index: true, null: false
      t.references :location, index: true, null: false

      t.timestamp null: false
    end
  end
end
