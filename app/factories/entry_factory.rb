class EntryFactory
  def self.create_from_entry_form(params, user)
    event = Event.find(params[:entry][:event])
    entry_parameter = EntryParameter.new(params, event, user)
    entry = Entry.new(entry_parameter.to_h)
    entry.entry_player = EntryPlayerFactory.create_from_entry_form(params, event.number)
    entry
  end
end
