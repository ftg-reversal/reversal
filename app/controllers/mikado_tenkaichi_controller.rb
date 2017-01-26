class MikadoTenkaichiController < ApplicationController
  before_action :set_entries, only: [:index]
  before_action :set_status, only: [:index, :vote]

  def index; end

  def vote
    if request.post?
      if params[:entry_id].nil?
        redirect_to mikado_tenkaichi_path, alert: '投票するプレイヤーを選んでください'
      elsif params[:entry_id].size > 4
        redirect_to mikado_tenkaichi_path, alert: '投票できるプレイヤーは4人までです'
      else
        save_status
        save_vote(params)
        save_vote_log(params)
      end
    end
  end

  private

  def save_status
    raise unless @status.can_vote
    @status.can_vote = false
    @status.save!
  rescue
    render_400
  end

  def save_vote(params)
    params[:entry_id].each do |entry_id|
      entry = MikadoTenkaichiEntry.find(entry_id)
      entry.count += 1
      entry.save!
    end
  end

  def save_vote_log(params)
    params[:entry_id].each do |entry_id|
      vote = MikadoTenkaichiVote.new
      vote.reversal_user = @current_user
      vote.mikado_tenkaichi_entry = MikadoTenkaichiEntry.find(entry_id)
      vote.save!
    end
  end

  def set_entries
    @entries = MikadoTenkaichiEntry.all
  end

  def set_status
    @status = MikadoTenkaichiVoteStatus.find_or_initialize_by(reversal_user: @current_user)
  end
end
