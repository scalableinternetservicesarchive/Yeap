class ChangeLocationPriceType < ActiveRecord::Migration
  def change
    change_column :locations, :avg_price, :string
  end
end
