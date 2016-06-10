class EventParameter
  include Commons::AttrAccessorExtension
  attr_accessor :title, :description, :datetime, :number, :entry_deadline, :reversal_user

  def initialize(attributes, reversal_user)
    @title = attributes['title']
    @description = attributes['description']
    @datetime = Time.zone.parse(attributes['datetime'])
    @entry_deadline = attributes['entry_deadline'] == '' ? '' : Time.zone.parse(attributes['entry_deadline'])
    @number = attributes['number'].to_i
    @reversal_user = reversal_user
    freeze
  end
end
