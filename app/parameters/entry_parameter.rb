class EntryParameter
  include Commons::AttrAccessorExtension
  attr_accessor :comment, :event, :reversal_user

  def initialize(attributes, event, user)
    @comment = attributes[:entry][:comment]
    @event = event
    @reversal_user = user
    freeze
  end
end
