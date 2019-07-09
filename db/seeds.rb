puts '--> Creating users...'
User.create(
  email: "thanhtruong1216@gmail.com",
  user_name: "Julia",
  full_name: "Julia Robert",
  password: "123456",
  password_confirmation: "123456",
)

60.times do |n|
  email = Faker::Internet.email
  user_name = Faker::Artist.name
  full_name = Faker::Name.name
  password =  "opensesame"
  file = File.open(Rails.root.join('db', 'avatar', "#{n+1}.jpg"))
  unless User.exists?(user_name: user_name)
    new_user = User.new(
      email: email,
      user_name: user_name,
      full_name: full_name,
      password: password,
      password_confirmation: password
    )
    new_user.avatar.attach(io: file, filename: "image#{n+1}")
    new_user.save
  end
end

puts '--> Creating posts...'

User.find_each do |user|
  9.times do |n|
    content = Faker::TvShows::GameOfThrones.quote
    image_index = ((user.id * 9 + n) % 30) + 1
    file = File.open(Rails.root.join('db', 'images', "#{image_index}.jpg"))

    p = Post.new(content:  content, user: user)
    p.photo.attach(io: file, filename: "image#{image_index}")
    p.save
  end
end

puts '--> Creating comments...'
20.times do |n|
  comment = Faker::Quotes::Shakespeare.romeo_and_juliet_quote
  Comment.create!(content: comment, user: User.first, post: Post.first)
end

puts '--> Creating likes...'
1000.times do |n|
  Like.create!(user: User.first, post: Post.first)
end

puts '--> Creating relationships...'
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
