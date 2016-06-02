class CampaignsController < ApplicationController
  before_action :find_campaign, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  def new
    @campaign = Campaign.new
    3.times {@campaign.rewards.build}
  end

  def create
    # campaign_params = params.require(:campaign).permit(:title, :body, :goal, :end_date, :address, {rewards_attributes: [:amount, :description]})
    @campaign = Campaign.new(campaign_params)
    @campaign.user = current_user
    if @campaign.save
      # 20160516 schedule it to run in the future when the campaign is actually ended
      CampaignGoalJob.set(wait_until: @campaign.end_date).perform_later(@campaign)
    redirect_to campaign_path(@campaign), notice: "Campaign created!"
    else
    gen_count = 3 - @campaign.rewards.size
    gen_count.times {@campaign.rewards.build}
    flash[:notice] = "Errors"
    render :new
  end
  end

  def show
    # @campaign = Campaign.find params[:id]
  end

  def index
    @campaigns = Campaign.all.order("created_at DESC")
    respond_to do |format|
      format.json { render json: @campaigns.to_json}
      format.html { render }
    end
  end

  def edit
    # @campaign = Campaign.find params[:id]
  end

  def update
    # @campaign = Campaign.find params[:id]
    # campaign_params = params.require(:campaign).permit([:title,:body,:goal,:end_date])
    if @campaign.update campaign_params
    redirect_to campaign_path(@campaign), notice: "updated!"
  else
    render :edit
  end
  end

  def campaign_params
    params.require(:campaign).permit(:title, :body, :goal, :end_date, :address,
                                    {rewards_attributes: [:amount, :description, :id, :_destroy]})
  end

  def destroy
    # @campaign = Campaign.find params[:id]
    @campaign.destroy
    redirect_to campaigns_path, notice: "deleted!"
  end

  def find_campaign
    @campaign = Campaign.find(params[:id]).decorate
  end
end
