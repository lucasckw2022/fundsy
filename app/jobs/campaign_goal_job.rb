class CampaignGoalJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # 20160516 0args , 0 will return empty array
    # 20160516 *args , * will make it optional
    campaign = args[0]
    pledges_amount = campaign.pledges.sum(:amount)
    if pledges_amount >= campaign.goal
      Rails.logger.info ">>> Campaign Funded"
    else
      Rails.logger.info ">>> Campaign Funded"
    end
  end
end
