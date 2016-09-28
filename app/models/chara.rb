# == Schema Information
#
# Table name: charas
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  en_name    :string(255)
#  abbrev     :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Chara < ApplicationRecord
end
