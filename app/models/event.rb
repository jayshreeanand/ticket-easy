class Event < ActiveRecord::Base
  has_many :bookings
  has_many :users, :through => :bookings

  def register(user)
    Booking.transaction do 
      booking = Booking.where(user: user, event: self).first_or_create
      booking.attending = true
      return booking.save!
    end
  end

  def unregister(user)
    booking = Booking.where(user: user, event: self).first
    if booking.present?
      booking.attending = false
      return booking.save!
    end
  end

  def valid? #not a past event
    return self.start_time > DateTime.now
  end

end
