class ReversalUserDecorator < Draper::Decorator
  delegate_all

  def name
    if !object.name.nil?
      object.name
    elsif object.slack_user
      object.slack_user.name
    elsif object.twitter_user
      object.twitter_user.name
    end
  end

  def bio
    return '' if object.bio&.nil? || object.bio.nil?
    object.bio
  end

  def short_bio
    if bio&.size > 30
      "#{bio&.slice(0, 30)}..."
    else
      bio
    end
  end
end
