# == Schema Information
#
# Table name: entries
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  chara_id         :integer
#  rank_id          :integer
#  comment          :text(65535)
#  event_id         :integer
#  reversal_user_id :integer
#  twitter_user_id  :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class EntriesController < ApplicationController
  before_action :set_entry, only: [:destroy]

  def create
    @entry = Entry.new(entry_params)

    if @entry.valid?
      @entry.save
      redirect_to event_entried_url(event_id: @entry.event.id)
    else
      redirect_to event_url(@entry.event), alert: @entry.errors.full_messages
    end
  end

  def destroy
    event = @entry.event
    @entry.destroy
    redirect_to event
  end

  private

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def entry_params
    n = params.require(:entry).permit(:name, :comment)
    n[:chara] = Chara.find(params.require(:entry)[:chara])
    n[:rank] = Rank.find(params.require(:entry)[:rank])
    n[:event] = Event.find(params.require(:entry)[:event])
    n[:reversal_user] = @current_user if @current_user
    n[:twitter_user] = @twitter_user if @twitter_user
    n
  end
end
