class MessageApiSerializer < ActiveModel::Serializer
  attributes :id, :slack_user, :channel, :date, :format_text, :ts, :image, :attachments

  def channel
    object.slack_channel.name
  end

  def date
    scope.nil? ? object.date : scope.l(object.date)
  end
end
