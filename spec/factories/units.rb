FactoryBot.define do
  factory :unit do
    association :chapter
    name { 'A Unit' }
    content { 'A Unit content' }
    description { 'A Unit description' }
    order { 1 }
  end
end