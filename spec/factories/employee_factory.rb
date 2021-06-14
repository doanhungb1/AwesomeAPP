FactoryBot.define do
  factory :employee do
    name { Faker.name }
    title { 'Title' }
  end
end
