class CreateVote < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    
      t.references :comment, index: true, null: false
      t.references :user, index: true, null: false

      t.integer :upvote, default: 0
      t.integer :downvote, default: 0

      t.timestamps null: false

    end
  end
end
