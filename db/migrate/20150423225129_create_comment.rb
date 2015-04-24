class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    
      t.references :user, index: true
      t.references :location, index: true

      t.text :content, null: false
      t.integer :rate, null: false
      t.timestamps null: false

      t.integer :upvote, default: 0
      t.integer :downvote, default: 0

    end
  end
end
