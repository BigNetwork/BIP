class Track < ActiveRecord::Base
  belongs_to :playlist
  has_many :votes
  acts_as_list :scope => :playlist
  
  # Output length in minutes instead of seconds:
  def length_in_minutes
    "%.2f" % (read_attribute(:length) / 60) unless read_attribute(:length).blank?
  end
end
