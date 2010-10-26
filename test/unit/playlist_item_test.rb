require 'test_helper'

class PlaylistItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: playlist_items
#
#  id          :integer         not null, primary key
#  playlist_id :integer
#  track_id    :integer
#  votes_count :integer
#  created_at  :datetime
#  updated_at  :datetime
#  spotify_id  :string(255)
#

