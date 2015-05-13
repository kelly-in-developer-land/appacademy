# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :integer          not null
#  end_date   :integer          not null
#  status     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, presence: true, inclusion: { in: %w(PENDING APPROVED DENIED), message: "Invalid status."}

  validate :overlapping_approved_requests

  belongs_to :cat

  after_initialize :set_status_to_pending

  def set_status_to_pending
    self.status ||= "PENDING"
  end

  #This is where you left off!
  def approve!
    ActiveRecord::Base.transaction do
      self.status = "APPROVED"
      self.save
      overlapping_pending_requests.each { |request| request.deny! }
    end
  end

  def deny!
    self.status = "DENIED"
    self.save
  end

  #You were working on this.
  def overlapping_requests
    CatRentalRequest.where("? BETWEEN start_date AND end_date OR ? BETWEEN start_date AND end_date", self.start_date, self.end_date)
  end

  def overlapping_pending_requests
    overlapping_requests.select { |request| request.status == "PENDING" }
  end

  def overlapping_approved_requests
    if overlapping_requests.any? { |request| request.status == "APPROVED" }
      record.errors[:overlapping] << 'Your request overlaps with an approved request!'
    end
  end

end
