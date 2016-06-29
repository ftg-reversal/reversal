class ReversalUserDecorator < Draper::Decorator
  delegate_all

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
