FactoryBot.define do
  factory :chapter do
    association :course
    name { 'A Chapter' }
    order { 1 }
  end
end