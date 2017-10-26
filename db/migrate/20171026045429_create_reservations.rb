class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :listing, index: true
      t.datetime :check_in
      t.datetime :check_out
      t.timestamps
    end
  end
end
