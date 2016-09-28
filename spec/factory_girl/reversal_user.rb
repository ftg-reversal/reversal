FactoryGirl.define do
  factory :reversal_user do
    sequence(:twitter_user_id) { |n| n }
    slack_user_id nil
    sequence(:screen_name) { |n| "screen_name_#{n}" }
  end
end
