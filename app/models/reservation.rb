class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing


  validate :overlap_dates

  def overlap_dates # reservation.overlapt_dates
    if self.listing.reservations.where("(? >= check_in AND ? <= check_out) OR (? >= check_in AND ? <= check_out)", self.check_in, self.check_in, self.check_out, self.check_out).count > 1
      errors.add(:check_in, " overlaps")
    end
  end

end
