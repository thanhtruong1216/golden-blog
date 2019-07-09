FactoryBot.define do
  factory :comment do |f|
    user
    post
    f.content { Faker::Quotes::Shakespeare.romeo_and_juliet_quote }
  end
end
