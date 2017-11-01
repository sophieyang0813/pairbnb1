class Listing < ApplicationRecord
    # belongs_to :user?
    mount_uploaders :avatars, AvatarUploader #182 upload image
    belongs_to :user
    has_many :reservations
    #185 reservation many-to-many? 1) created the model reservation, 2) establish many to many among listing, user, and reservation

    #195A see index method 
  scope :price_range, -> (price) { where price_per_night: price }
  scope :city, -> (location) { where location: location }
  scope :room_type, -> (type) { where room_type: type }
  # scope :dates, -> (checkin, checkout) { where check_in: checkin, check_out: checkout }

  # def self.dates 
  # 	where(check_in: 'params' && check_out: 'params')
  # end 
  # scope :dates -> (dates) { where check_in}

  # reservations.where("(? >= check_in AND ? <= check_out) OR (? >= check_in AND ? <= check_out)", self.check_in, self.check_in, self.check_out, self.check_out).count > 1
  #     errors.add(:check_in, " overlaps")
  # scope :starts_with, -> (name) { where("room_type like ?", "#{name}%")}


end