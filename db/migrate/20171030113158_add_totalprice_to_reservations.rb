class AddTotalpriceToReservations < ActiveRecord::Migration[5.1]
  def change
  	add_column :reservations, :total_price, :integer
  end
end
