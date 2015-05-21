class Event < ActiveRecord::Base
  has_many :bookings
  has_many :users, :through => :bookings

  def register(user)
    Booking.where(user: user, event: self).first_or_create!(attending: true)
  end

  def unregister(user)
    booking = Booking.where(user: user, event: self).first
    if booking.present?
      booking.attending = false
      return booking.save!
    end
  end


end
