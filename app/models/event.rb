class Event < ActiveRecord::Base
  has_many :bookings
  has_many :users, :through => :bookings

  def register(user)
    #To make sure booking entry is not created for invalid events
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

  def valid? 
    #not a past event
    self.start_time > DateTime.now
  end

end
