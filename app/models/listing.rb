class Listing < ApplicationRecord
    # belongs_to :user?
    mount_uploaders :avatars, AvatarUploader #182 upload image
    belongs_to :user
    has_many :reservations
    #185 reservation many-to-many? 1) created the model reservation, 2) establish many to many among listing, user, and reservation

    #195A see index method 
  scope :price_range, -> (price) { where price_per_night: price }
  scope :city, -> (location) { where location: location }
  scope :starts_with, -> (name) { where("name like ?", "#{name}%")}


end