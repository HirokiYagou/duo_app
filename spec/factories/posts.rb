FactoryBot.define do
  factory :post do
    content { Faker::Movies::HarryPotter.quote }
    association :user

    after(:build) do |post|
      post.image.attach(io: File.open('public/images/icon11.png'), filename: 'icon11.png')
    end
  end

end
