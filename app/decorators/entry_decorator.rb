class EntryDecorator < Draper::Decorator
  delegate_all

  def rank_name
    object.rank.rank
  end

  def chara_name
    object.chara.name
  end
end
