# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name: 'Example User',
             email: 'example@railstutorial.org',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true, 
             activated: true,
             activated_at: Time.zone.now )

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now )
end

path = 'db/seeds/data.json'

# must modify the current 'data.json' by adding objects in one single object
places = ActiveSupport::JSON.decode(File.read(path))
#puts places["title"]

place_id = 0
categories = {}

# add each place
places.each do |place|
  place_id = place_id + 1
  puts place_id
  l = Location.find_by(:name => place['name'])
  if l.nil?
    Location.create!(:name => place['name'], :address => place['address'], :img_url => place['img_name']+'.jpg', :intro => place['intro'], :avg_price => place['avg_price'], :rate => place['rate'])
  end

end
puts place_id.to_s + ' locations has been added into Place'
