class SendCampaignSummaryJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    campaign = atgs[0]
    puts ">>>>> sending campaign summary #{campaign.title}"
    # begin
    #   # attempt to send the summary
    # rescue
    #   # let admin know to fix bug
    # ensure
    #   # schedule the next one regardless
    #   # SendCampaignSummaryJob.set(wait_until: Time.now + 1.hour).perform_later(campaign)
    # end
  end
end
