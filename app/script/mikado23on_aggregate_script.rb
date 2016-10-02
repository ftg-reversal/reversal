class Mikado23onAggregateScript
  def self.exec
    charas = Mikado23onVote.column_names.select { |column| column.match(/^[A-Z][a-z]+/) }

    Mikado23onVote.all.select { |vote| vote.reversal_user.twitter_user }.each do |vote|
      print "#{vote.reversal_user.twitter_user.name},"
      print "#{vote.reversal_user.twitter_user.screen_name},"
      print "#{vote.area},"

      charas.each do |chara|
        entry_num = vote[chara]
        player = Mikado23onEntry.find_by(area: vote.area, chara: Chara.find_by(en_name: chara), entry_num: entry_num)&.name
        player = player ? player : '投票なし'
        print "#{player},"
      end
      if vote.created_at
        puts vote.created_at
      else
        puts ''
      end
    end
  end
end
