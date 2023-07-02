FactoryBot.define do
  factory :course do
    association :instructor
    name { 'A Course' }
    description { 'A Course description' }
  end
end