class EntryParameter
  include Commons::AttrAccessorExtension
  attr_accessor :name, :chara, :rank, :comment, :event, :reversal_user, :twitter_user

  def initialize(attributes, reversal_user = nil, twitter_user = nil)
    attributes.assert_valid_keys('name', 'chara', 'rank', 'comment', 'event')

    @name = attributes['name']
    @comment = attributes['comment']
    @chara = Chara.find(attributes['chara'])
    @rank = Rank.find(attributes['rank'])
    @event = Event.find(attributes['event'])
    @reversal_user = reversal_user
    @twitter_user = twitter_user
    freeze
  end
end
