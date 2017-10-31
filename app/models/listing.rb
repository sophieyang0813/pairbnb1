class Listing < ApplicationRecord
    # belongs_to :user?
    mount_uploaders :avatars, AvatarUploader #182 upload image
    belongs_to :user
    has_many :reservations
    #185 reservation many-to-many? 1) created the model reservation, 2) establish many to many among listing, user, and reservation

end