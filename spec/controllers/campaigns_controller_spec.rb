require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do

  let(:campaign) { FactoryGirl.create(:campaign) }
  # is equivalent to:
  # # this technique is called memoization
  # def campaign
  #   # if @campaign is nil it will call FactoryGirl.create(:campaign)
  #   # otherwise it will just return @campaign
  #   @campaign ||= FactoryGirl.create(:campaign)
  # end

  # If you want to force creating a campaign then you can use:
  # let!(:campaign) { FactoryGirl.create(:campaign) }

  describe "#new" do
    before { get :new }

    it "renders the new template" do
      # response is an object that RSpec provides us that will contain the
      # controller response data which will help us test things such as rendering
      # templates or redirecting to a specific page.
      # render_template is a matcher from rspec-rails to test rendering a specific
      # Rails template
      expect(response).to render_template(:new)
    end

    it "assigns a campaign object" do
      expect(assigns(:campaign)).to be_a_new(Campaign)
    end
  end

  describe "#create" do
    describe "with valid attributes" do
      # methods defined with in `describe` are only available to examples
      # defined within the same describe (also applies to `context`)
      def valid_request
        post :create, campaign: FactoryGirl.attributes_for(:campaign)
      end

      it "saves a record to the database" do
        count_before = Campaign.count
        valid_request
        count_after = Campaign.count
        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the campaign's show page" do
        valid_request
        expect(response).to redirect_to(campaign_path(Campaign.last))
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    describe "with invalid attributes" do
      def invalid_request
        post :create, campaign: {goal: 12}
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "sets an alert message" do
        invalid_request
        expect(flash[:notice]).to be_present
      end

      it "doesn't save a record to the database" do
        count_before = Campaign.count
        invalid_request
        count_after = Campaign.count
        expect(count_after).to eq(count_before)
      end
    end
  end

  describe "#show" do
    before do
      # @c = FactoryGirl.create(:campaign)
      get :show, id: campaign.id
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "sets a campaign instance variable" do
      expect(assigns(:campaign)).to eq(campaign)
    end
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns an instance variable to all campaigns in the DB" do
      c = FactoryGirl.create(:campaign)
      c1 = FactoryGirl.create(:campaign)
      get :index
      expect(assigns(:campaigns)).to eq([c,c1])
    end
  end

  describe "#edit" do
    it "renders the edit template" do
      get :edit, id: campaign.id
      expect(response).to render_template(:edit)
    end
    it "sets an instance varible with the passed id" do
      get :edit, id: campaign.id
      # byebug
      expect(assigns(:campaign)).to eq(campaign)
    end
  end

  describe "#update" do
    describe "with valid params"do
    let(:new_valid_body) {Faker::ChuckNorris.fact}
    before do
        patch :update, id: campaign.id, campaign: {body: new_valid_body}
      end

      it "updates the record whose id is passed" do
        expect(campaign.reload.body).to eq(new_valid_body)
      end
      it "redirects to show page" do
        expect(response).to redirect_to(campaign_path(campaign))
      end
      it "sets a flash notice message" do
        expect(flash[:notice]).to be()
      end
    end
    describe "with invalid params" do
      before do
        patch :update, id: campaign.id, campaign: {title:""}
      end
      it "doesnt update the record " do
        expect(campaign.title).to eq(campaign.reload.title)
      end
      it "render the edit template" do
        expect(response).to render_template(:edit)
      end
    end
    describe "#destroy" do
      it "removes the campaign from the database"do
      campaign
      count_before = Campaign.count
      delete :destroy, id: campaign.id
      count_after = Campaign.count
      expect(count_after).to eq(count_before -1)
      # expect{delete:destroy, id: campaign.id}.to change{Campaign.count}.by(-1)
    end
      it "redirect to the index page"do
        delete :destroy, id:campaign.id
        expect(response).to redirect_to(campaigns_path)
      end
      it "sets a flash" do
        delete :destroy, id:campaign.id
        expect(flash[:notice]).to be_present
      end
    end
  end

end
