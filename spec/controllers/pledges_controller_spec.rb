require 'rails_helper'

RSpec.describe PledgesController, type: :controller do
  let(:campaign) { FactoryGirl.create(:campaign) }
  # def campaign
  #   @campaign ||= FactoryGirl.create(:campaign)
  # end
  let(:user) { FactoryGirl.create(:user) }

  describe "#new" do
    context "without a signed in user" do
      it "redirects to sign up page" do
        get :new, campaign_id: campaign.id
        expect(response).to redirect_to new_user_path
      end
    end
    context "with signed in user" do
      # we set the session[:user_id] to a valid user id to emulate user being
      # signed in
      before { login(user) }
      it "renders the new template" do
        get :new, campaign_id: campaign.id
        expect(response).to render_template(:new)
      end

      it "assigns a new pledge instance variable" do
        get :new, campaign_id: campaign.id
        expect(assigns(:pledge)).to be_a_new(Pledge)
      end
    end
  end

  describe "#create" do


  end
end
