class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  before_save :event_valid?


  private
  def event_valid?
    self.event.valid?
  end
end
