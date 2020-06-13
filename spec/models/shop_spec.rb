require 'rails_helper'

RSpec.describe Shop, type: :model do
  describe 'association' do
    it { should have_many(:narwhal_orders) }
  end
end
