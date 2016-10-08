FactoryGirl.define do
  factory :event do
    sequence(:reversal_user_id) { |n| n }
    sequence(:title) { |n| "title_#{n}" }
    sequence(:description) { |n| "description_#{n}" }
    datetime Time.zone.parse('2015-01-02 00:00:00 +0900')
    entry_deadline Time.zone.parse('2015-01-02 00:00:00 +0900')
    number 3
  end
end
