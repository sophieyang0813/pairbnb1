class Listing < ApplicationRecord
    belongs_to :user
    mount_uploaders :avatars, AvatarUploader #182 upload image


end