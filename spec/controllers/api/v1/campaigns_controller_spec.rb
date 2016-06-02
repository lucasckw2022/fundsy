require 'rails_helper'

RSpec.describe Api::V1::CampaignsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let!(:campaign) { FactoryGirl.create(:campaign) }

  # render_views

  describe "#index" do
    context "with no API key" do
      it "responds with a 403 HTTP status code" do
        get :index, format: :json
        expect(response.status).to eq(403)
      end
    end
    context "with api key" do
      it "renders the campaign's title the in the JSON response" do
        campaign
        get :index, api_key: user.api_key, format: :json
        expect(response.body).to have_text /#{campaign.title.titleize}/i
      end
    end
  end

  describe "#show" do
    context "with api_key provided" do
      it "renders a JSON with a campaign title" do
        get :show, id: campaign.id, format: :json, api_key: user.api_key
        response_body = JSON.parse(response.body)
        expect(response_body["campaign"]["title"]).to eq(campaign.title.titleize)
      end
    end
  end

end
