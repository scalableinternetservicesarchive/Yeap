class AddRateToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :rate, :string
  end
end
