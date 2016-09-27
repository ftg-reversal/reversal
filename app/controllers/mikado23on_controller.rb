class Mikado23onController < ApplicationController
  before_action :set_chara, only: [:east, :west]
  before_action :set_east_entries, only: [:east]
  before_action :set_west_entries, only: [:west]
  before_action :set_status, only: [:east, :west, :vote]
  before_action :set_area, only: [:vote]

  def index
  end

  def east
  end

  def west
  end

  def vote
    if request.post?
      save_status(params['area'])
      save_vote(params)
      save_vote_log(params)
    end
  end

  private

  def save_status(area)
    if area == 'east'
      raise unless @status.can_east
      @status.can_east = false
    elsif area == 'west'
      raise unless @status.can_west
      @status.can_west = false
    end
    @status.save!
  rescue
    render_400
  end

  def save_vote(params)
    Chara.all.each do |chara|
      next if params[chara.en_name].to_i.zero?
      entry = Mikado23onEntry.find_by(area: params['area'], chara: chara, entry_num: params[chara.en_name])
      entry.count += 1
      entry.save!
    end
  end

  def save_vote_log(params)
    vote = Mikado23onVote.new
    vote.reversal_user = @current_user
    vote.area = params['area']
    Chara.all.each do |chara|
      vote[chara.en_name] = params[chara.en_name]
    end
    vote.save!
  end

  def set_chara
    @chara = Chara.all
  end

  def set_east_entries
    @entries = {}
    Chara.all.each do |chara|
      @entries[chara.name] = Mikado23onEntry.where(area: 'east', chara: chara)
    end
  end

  def set_west_entries
    @entries = {}
    Chara.all.each do |chara|
      @entries[chara.name] = Mikado23onEntry.where(area: 'west', chara: chara)
    end
  end

  def set_status
    @status = Mikado23onVoteStatus.find_or_initialize_by(reversal_user: @current_user)
  end

  def set_area
    @area = params['area']
  end
end
