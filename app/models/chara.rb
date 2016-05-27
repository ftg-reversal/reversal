# == Schema Information
#
# Table name: charas
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  en_name    :string(255)
#

class Chara < ActiveRecord::Base
end
