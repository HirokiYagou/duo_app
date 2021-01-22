FactoryBot.define do
  factory :user do
    username              { Faker::Science.element + "#{rand(0..99)}" + '_' }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 4) }
    password_confirmation { password }
    last_name             { Faker::Name.last_name }
    first_name            { Faker::Name.first_name }
  end
end
