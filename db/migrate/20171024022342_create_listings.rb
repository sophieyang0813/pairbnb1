class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.belongs_to :user,  index: true
      t.integer :guest_num
      t.string :location
      t.string :room_type
      t.timestamps
    end
  end
end
