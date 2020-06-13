require 'rails_helper'

RSpec.describe NarwhalOrder, type: :model do
  describe 'association' do
    it { should belong_to(:shop) }
  end
end
