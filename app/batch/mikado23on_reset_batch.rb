class Mikado23onResetBatch
  class << self
    def exec
      Mikado23onVoteStatus.all.each do |status|
        status.can_east = true
        status.can_west = true
        status.save!
      end
    end
  end
end
