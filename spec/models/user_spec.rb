require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do
    it "requires a first name" do
      u = User.new FactoryGirl.attributes_for(:user).merge({first_name:nil})
        expect(u).to be_invalid
    end
    it "requires a last name"do
    u = User.new FactoryGirl.attributes_for(:user).merge({last_name:nil})
      expect(u).to be_invalid
    end
    it "requires an email" do
    u = User.new FactoryGirl.attributes_for(:user).merge({email:nil})
      expect(u).to be_invalid
    end
    it "require a unique email" do
      # this is to create a new record and save
      u = FactoryGirl.create(:user)
      u2 = User.new FactoryGirl.attributes_for(:user).merge({email:u.email})
      expect(u2).to be_invalid
    end
  end
  describe ".first_name" do
    it "return concatenated first and last name" do
      u = User.new FactoryGirl.attributes_for(:user).merge({first_name:"John",last_name:"Smith"})
      expect(u.full_name).to eq("John Smith")
    end
  end
  describe "hasing the password" do
    it "generates a password digest" do
      u = User.new FactoryGirl.attributes_for(:user)
      u.save
      expect(u.password_digest).to be
    end
  end
end
