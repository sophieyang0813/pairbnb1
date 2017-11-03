#sy: create a fake user to test your app


#seed user
user = {}
user['password'] = 'asdf'


ActiveRecord::Base.transaction do
    5.times do
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
    10.times do
        listing['guest_num'] = rand(1..9)
        listing['location'] = ["Tokyo", "Seoul", "New York", "London", "Singapore", "Beijing", "Berlin", "Moscow"].sample
        listing['room_type'] = ["Private room", "Shared room", "Entire place"].sample
        listing['user_id'] = uids.sample
        listing['price_per_night'] = rand(10..100)

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

