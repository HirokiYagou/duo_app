FactoryBot.define do
  factory :term do
    sentence_id { rand(1..560) }
    word_id     { rand(0..2569) }
    lesson      { rand(1..45) }
    english     { Faker::Lorem.sentence }
    japanese    { Faker::Lorem.sentence }
  end
end
