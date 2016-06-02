class PledgeSerializer < ActiveModel::Serializer
  attributes :id, :amount,:username

  def username
    object.user.full_name if object.user
  end
end
