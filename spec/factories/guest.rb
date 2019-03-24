FactoryBot.define do
  factory :guest do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email }
    document_id { Faker::IDNumber.valid }
  end
end
