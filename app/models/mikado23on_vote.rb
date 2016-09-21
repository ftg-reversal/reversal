# == Schema Information
#
# Table name: mikado23on_votes
#
#  id               :integer          not null, primary key
#  reversal_user_id :integer          not null
#  area             :string(255)      not null
#  Sol              :integer          default(0), not null
#  Ky               :integer          default(0), not null
#  May              :integer          default(0), not null
#  Millia           :integer          default(0), not null
#  Zato             :integer          default(0), not null
#  Potemkin         :integer          default(0), not null
#  Chipp            :integer          default(0), not null
#  Faust            :integer          default(0), not null
#  Axl              :integer          default(0), not null
#  Slayer           :integer          default(0), not null
#  Venom            :integer          default(0), not null
#  Ino              :integer          default(0), not null
#  Bedman           :integer          default(0), not null
#  Ramlethal        :integer          default(0), not null
#  Sin              :integer          default(0), not null
#  Elphelt          :integer          default(0), not null
#  Leo              :integer          default(0), not null
#  Johnny           :integer          default(0), not null
#  Jack-O           :integer          default(0), not null
#  Jam              :integer          default(0), not null
#  Kum              :integer          default(0), not null
#  Raven            :integer          default(0), not null
#  Dizzy            :integer          default(0), not null
#

class Mikado23onVote < ApplicationRecord
  belongs_to :reversal_user
end
