class MikadoTenkaichiResetBatch
  class << self
    def exec
      MikadoTenkaichiVoteStatus.all.each do |status|
        status.can_vote = true
        status.save!
      end
    end
  end
end
