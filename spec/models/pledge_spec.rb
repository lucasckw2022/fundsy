require 'rails_helper'

RSpec.describe Pledge, type: :model do
  describe "validation" do
    it "require an amount" do
      p = Pledge.new(FactoryGirl.attributes_for(:pledge).merge({amount: -1}))
      expect(p).to be_invalid
    end
  end
end
