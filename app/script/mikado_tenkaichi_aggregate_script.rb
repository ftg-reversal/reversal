class MikadoTenkaichiAggregateScript
  def self.exec
    MikadoTenkaichiVote.all.select { |vote| vote.reversal_user.twitter_user }.each do |vote|
      print "#{vote.reversal_user.twitter_user.name},"
      print "#{vote.reversal_user.twitter_user.screen_name},"
      puts  "#{vote.mikado_tenkaichi_entry.name}"
    end
  end
end
