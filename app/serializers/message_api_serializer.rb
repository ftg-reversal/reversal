class MessageApiSerializer < ActiveModel::Serializer
  attributes :id, :slack_user, :username, :icon_url, :channel, :date, :format_text, :ts, :image, :attachments

  def username
    object.username
  end

  def icon_url
    object.icon
  end

  def channel
    object.slack_channel.name
  end

  def date
    scope.nil? ? object.date : scope.l(object.date)
  end
end
