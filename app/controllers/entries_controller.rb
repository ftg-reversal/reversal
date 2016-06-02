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
#  fk_rails_20eb5df311        (event_id)
#  fk_rails_6a9722b611        (reversal_user_id)
#  fk_rails_8580cf0bd4        (twitter_user_id)
#  index_entries_on_chara_id  (chara_id)
#  index_entries_on_rank_id   (rank_id)
#

class EntriesController < ApplicationController
  before_action :set_entry, only: [:destroy]
  before_action :do_check_any_login, only: [:create, :destroy]
  before_action :ensure_permission, only: [:destroy]

  def create
    parameter = EntryParameter.new(params[:entry], @current_user, @twitter_user)
    @entry = Entry.new(parameter.to_h)
    event = @entry.event

    if event.can_entry? && @entry.save
      redirect_to event_url(event)
    else
      redirect_to event_url(event), alert: @entry.errors.full_messages
    end
  end

  def destroy
    event = @entry.event
    @entry.destroy if event.can_entry?
    redirect_to event, status: :see_other
  end

  private

  def set_entry
    @entry = Entry.find(params[:id])
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
