# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  status     :string           not null
#  lyrics     :text
#  album_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base
  validates :title, presence: true
  validates :status, presence: true
  validates :album_id, presence: true

  belongs_to :album
  has_one :band, through: :album
  
  has_many :notes
end
