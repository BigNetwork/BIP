class Album < ActiveRecord::Base
  validates_presence_of :spotify_id
end

# == Schema Information
#
# Table name: albums
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  spotify_id :string(255)
#  released   :integer
#  created_at :datetime
#  updated_at :datetime
#

