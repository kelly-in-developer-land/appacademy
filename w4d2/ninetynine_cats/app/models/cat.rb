# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string           not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base

  validates :birth_date, presence: true
  validates :color, presence: true
  validates :name, presence: true
  validates :sex, presence: true

  validate :single_letter_sex

  has_many :cat_rental_requests, dependent: :destroy

  def age
    age = Time.now.year - birth_date.year
    return age - 1 if Time.now.yday < birth_date.yday
    age
  end

  def single_letter_sex
    sex == "M" || sex == "F"
  end

end
