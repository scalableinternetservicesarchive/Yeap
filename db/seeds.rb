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

501.times do |n|
  puts n
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

puts "501 users added"
################################################################################

path = 'db/seeds/data.json'

# must modify the current 'data.json' by adding objects in one single object
places = ActiveSupport::JSON.decode(File.read(path))
#puts places["title"]

place_id = 0

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

path = 'db/seeds/faked_data.json'

# must modify the current 'data.json' by adding objects in one single object
puts "start to decode faked_data.json"
places = ActiveSupport::JSON.decode(File.read(path))
puts "start to insert faked_data.json into data base"

#puts places["title"]

#place_id = 0

# add each place
places.each do |place|
  place_id = place_id + 1
  puts place_id
  Location.create!(:name => place['name'], :address => place['address'], :img_url => place['img_name']+'.jpg', :intro => place['intro'], :avg_price => place['avg_price'], :rate => place['rate'])

end
puts place_id.to_s + ' locations has been added into Place'

################################################################################

path = 'db/seeds/data.json'

# must modify the current 'data.json' by adding objects in one single object
places = ActiveSupport::JSON.decode(File.read(path))
#puts places["title"]

place_id = 0

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
################################################################################


path = 'db/seeds/faked_comments.json'

# must modify the current 'data.json' by adding objects in one single object
puts "start to decode faked_comments.json"
comments = ActiveSupport::JSON.decode(File.read(path))
puts "start to insert faked_comments.json into data base"

#puts places["title"]

#place_id = 0
comment_id = 0
# add each place
comments.each do |comment|
  comment_id = comment_id + 1
  puts comment_id
  Comment.create!(:user_id => comment['user_id'], :location_id => comment['location_id'], :content => comment['content'], :rate => comment['rate'], :upvote => comment['upvote'], :downvote => comment['downvote'], :user_name => "")

end
puts comment_id.to_s + ' comments has been added into Comment'
=begin

###############################################################33
puts "adding one comment to each location"
10443.times do |n|
  puts n
  name = Faker::Name.name
  Comment.create!(:user_id => comment['user_id'], :location_id => n, :content => comment['content'], :rate => comment['rate'], :upvote => comment['upvote'], :downvote => comment['downvote'], :user_name => "")
end
puts "seeds done"
=end
