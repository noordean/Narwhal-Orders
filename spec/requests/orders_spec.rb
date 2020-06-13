require 'rails_helper'

RSpec.describe "NarwhalOrders", type: :request do
  def login(shop)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:shopify,
      provider: 'shopify',
      uid: shop.shopify_domain,
      credentials: { token: shop.shopify_token }
    )
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:shopify]

    get "/auth/shopify"
    follow_redirect!
  end

  describe "GET narwhal-orders" do
    let(:shop) { create(:shop) }
    let!(:narwhal_order) { create(:narwhal_order, shop: shop) }

    before do
      stub_request(:get,
        "https://#{shop.shopify_domain}/admin/api/#{shop.api_version}/shop.json").
        with(
          headers: {
          'Accept'=>'application/json',
          'X-Shopify-Access-Token'=> shop.shopify_token
          }).
        to_return(status: 200, body: { domain: shop.shopify_domain }.to_json, headers: {})
    end

    it "renders narwhal orders for the curremt shop" do
      login(shop)
      @request.session[:shopify] = shop.id
      @request.session[:shopify_domain] = shop.shopify_domain
      get root_path
      expect(response).to have_http_status(200)
      expect(assigns(:narwhal_orders)).to eq([narwhal_order])
    end
  end
end
