FactoryBot.define do
  factory :narwhal_order do
    name { '#1234' }
    customer { 'First_name Last_name' }
    order_id { '123456789' }
    shop
  end
end
