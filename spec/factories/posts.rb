FactoryBot.define do
  factory :post do |f|
    user
    f.content { Faker::TvShows::GameOfThrones.quote }
    after(:build) do |post|
      post.photo.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', '1.jpg')), filename: '1.jpeg', content_type: 'image/jpeg')
    end
  end
end
