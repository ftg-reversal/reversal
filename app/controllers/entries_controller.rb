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
# Indexes
#
#  fk_rails_20eb5df311  (event_id)
#  fk_rails_6a9722b611  (reversal_user_id)
#  fk_rails_8580cf0bd4  (twitter_user_id)
#

class EntriesController < ApplicationController
  before_action :set_entry, only: [:destroy]
  before_action :do_check_any_login, only: [:create, :destroy]
  before_action :ensure_permission, only: [:destroy]

  def create
    @entry = Entry.new(entry_params)
    event = @entry.event

    if @entry.save
      redirect_to event_entried_url(event_id: event.id)
    else
      redirect_to event_url(event), alert: @entry.errors.full_messages
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

  def ensure_permission
    if @current_user && @entry.reversal_user == @current_user
      true
    elsif @twitter_user == @entry.twitter_user
      true
    else
      redirect_to '/'
    end
  end
end
