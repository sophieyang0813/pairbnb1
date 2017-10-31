class User < ApplicationRecord
  # has_and_belongs_to_many :listings
  #IS THIS CORRECT? 185 rservation; see listing model- does 'belong to many' necessary? if so then do I delete has many in line 11?


  mount_uploader :avatar, AvatarUploader #182 uploading image; CarrierWave gem
  enum role: [ :customer, :admin, :moderator ] # 181 user authorization; ENUM active record class

  include Clearance::User
    has_many :authentications, dependent: :destroy
    has_many :listings
    # for depedent: :destroy see active record associations

    def self.create_with_auth_and_hash(authentication, auth_hash)
        # byebug
      user = self.create!(
        name: auth_hash["info"]["name"],
        email: auth_hash["info"]["email"],
        password: (('a'..'z').to_a + ('0'..'9').to_a).sample(8).join )
      user.authentications << authentication
      return user
    end


    # grab fb_token to access Facebook for user data
    def fb_token
        # byebug
      x = self.authentications.find_by(provider: 'facebook')
      return x.token unless x.nil?
    end
 end