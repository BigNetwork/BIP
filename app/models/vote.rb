class Vote < ActiveRecord::Base
  belongs_to :track, :counter_cache => true
  #belongs_to :playlist_item, :counter_cache => true
end

# == Schema Information
#
# Table name: votes
#
#  id         :integer         not null, primary key
#  track_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

