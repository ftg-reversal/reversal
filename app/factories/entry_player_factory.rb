class EntryPlayerFactory
  def self.create_from_entry_form(params, number)
    (0...number).to_a.map do |i|
      EntryPlayer.new(
        name: params[:names][i].empty? ? '未定' : params[:names][i],
        chara: Chara.find(params[:charas][i]),
        rank: Rank.find(params[:ranks][i])
      )
    end
  end
end
