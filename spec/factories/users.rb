FactoryBot.define do
  factory :user do |f|
    f.email     { Faker::Internet.email }
    f.user_name { Faker::Artist.unique.name }
    f.full_name { Faker::Name.name }
    f.password  { "opensesame" }
    after(:build) do |user|
      user.avatar.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', '1.jpg')), filename: '1.jpeg', content_type: 'image/jpeg')
    end
  end
end
