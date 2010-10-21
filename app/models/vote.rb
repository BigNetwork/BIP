class Vote < ActiveRecord::Base
  belongs_to :track, :counter_cache => true
  #belongs_to :playlist_item, :counter_cache => true
end
