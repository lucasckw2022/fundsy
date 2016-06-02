class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
  has_many :pledges
  # this is allowing serializer to use the helper method using include
  include ApplicationHelper

  def title
    object.title.titleize
  end

  def url
    campaign_url(object, host: "http://localhost:3000")
  end

  def created_at
    formatted_date(object.created_at)
  end
end
