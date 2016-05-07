class EventParameter
  include Commons::AttrAccessorExtension
  attr_accessor :title, :description, :datetime, :reversal_user

  def initialize(attributes, reversal_user)
    @title = attributes['title']
    @description = attributes['description']
    @datetime = Time.zone.parse(attributes['datetime'])
    @reversal_user = reversal_user
    freeze
  end
end
