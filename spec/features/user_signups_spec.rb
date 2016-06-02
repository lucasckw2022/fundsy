require 'rails_helper'

RSpec.feature "UserSignups", type: :feature do
  describe "valid user data" do
    it "redirects to the home page, displays the user name and show flash message" do

      visit new_user_path
      valid_attributes = FactoryGirl.attributes_for(:user)
      #need to fill this otherwise capybara wont know what to fill
      fill_in "First name", with: valid_attributes[:first_name]
      fill_in "Last name", with: valid_attributes[:last_name]
      fill_in "Email", with: valid_attributes[:email]
      fill_in "Password", with: valid_attributes[:password]
      # put in the same password
      fill_in "Password confirmation", with: valid_attributes[:password]

      click_button "Sign Up"

      full_name = "#{valid_attributes[:first_name]} #{valid_attributes[:last_name]}"
      expect(page).to have_text /#{full_name}/i
    end

  end
  describe "with invalid user data" do
    it "shows errors and stays on the form submissions page"do
    visit new_user_path
    click_button "Sign Up"
    expect(page).to have_text /can't be blank/i
    expect(current_path).to eq(users_path)
  end
  end
end
