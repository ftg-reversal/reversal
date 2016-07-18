# == Schema Information
#
# Table name: ranks
#
#  id         :integer          not null, primary key
#  rank       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rank < ApplicationRecord
end
