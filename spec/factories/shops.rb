FactoryBot.define do
  factory :shop do
    shopify_domain { 'myshop.myshopify.com' }
    shopify_token { 'some_token_here' }
  end
end
