require 'rails_helper'

RSpec.describe OrdersCreateJob, type: :job do
  include ActiveJob::TestHelper

  let!(:shop) { create(:shop) }
  let(:product_title) { "narwhal product" }
  let(:webhook) do
    {
      name: '#1234',
      customer: { first_name: "Nurudeen", last_name: "Ibrahim"},
      id: 123456,
      line_items: [{ title: product_title }]
    }
  end

  it 'queues as default' do
    expect(described_class.new.queue_name).to eq('default')
  end

  describe "perform" do
    context "when a product in the fetched webhook contains word 'narwhal'" do
      it 'creates a narwhal order' do
        previous_narwhal_orders_count = NarwhalOrder.count
        described_class.new.perform(shop_domain: shop.shopify_domain, webhook: webhook)

        expect(NarwhalOrder.count).to eq(previous_narwhal_orders_count + 1)
      end
    end

    context "when no product contains 'narwhal'" do
      let(:product_title) { 'a different product' }

      it 'does not create a narwhal order' do
        previous_narwhal_orders_count = NarwhalOrder.count
        described_class.new.perform(shop_domain: shop.shopify_domain, webhook: webhook)

        expect(NarwhalOrder.count).to eq(previous_narwhal_orders_count)
      end
    end
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
