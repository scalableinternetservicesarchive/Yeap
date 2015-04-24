class CreateLocation < ActiveRecord::Migration
  def change
    create_table :locations do |t|
        
      t.string :name, null: false, index: true
      t.string :address, null: false
      t.string :img_url, default: ""
      t.text :intro
      t.decimal :avg_price, precision: 6, scale: 2
      t.time :start_time, default: "00:00:00"
      t.time :end_time, default: "00:00:00"
      t.float :rate, default: 0.0, index: true
      t.float :latitude, default: 0.0
      t.flaot :longitude, default: 0.0

      t.timestamps null: false

    end
  end
end
