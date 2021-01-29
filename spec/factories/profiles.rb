FactoryBot.define do
  factory :profile do
    nickname { Faker::Team.name }
    status   { Faker::Movies::HarryPotter.quote }

    after(:build) do |profile|
      profile.icon.attach(io: File.open('public/images/icon11.png'), filename: 'icon11.png')
      profile.header.attach(io: File.open('public/images/icon11.png'), filename: 'icon11.png')
    end
  end
end
