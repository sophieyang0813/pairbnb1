class AddPricepernightToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :price_per_night, :integer
  end
end
