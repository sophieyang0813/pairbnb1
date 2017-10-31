#sy: create a fake user to test your app


#seed user
user = {}
user['password'] = 'asdf'


ActiveRecord::Base.transaction do
    20.times do
    user['name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email

    # user['password'] = Faker::Internet.password(8)

    User.create(user)
    end
end


#seed listings

listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
    40.times do
        listing['guest_num'] = rand(1..9)
        listing['location'] = Faker::Address.city
        listing['room_type'] = ["House", "Entire Floor", "Condominium", "Villa", "Townhouse", "Castle", "Treehouse", "Igloo", "Yurt", "Cave", "Chalet", "Hut", "Tent", "Other"].sample
        listing['user_id'] = uids.sample

        Listing.create(listing)
    end
end


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

