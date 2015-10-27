# == Schema Information
#
# Table name: search_conditions
#
#  id         :integer          not null, primary key
#  word       :string(255)      default(""), not null
#  video_site :string(255)      default(""), not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :search_condition do
    video_site VideoSite::Dummy
  end
end
