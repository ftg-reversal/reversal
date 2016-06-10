class EntryPlayerFactory
  def self.create_from_entry_form(params)
    number = Event.find(params[:entry][:event]).number
    (0...number).to_a.map do |i|
      EntryPlayer.new(
        name: params[:names][i],
        chara: Chara.find(params[:charas][i]),
        rank: Rank.find(params[:ranks][i])
      )
    end
  end
end
