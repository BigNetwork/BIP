require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: tracks
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  artist      :string(255)
#  album       :string(255)
#  href        :string(255)
#  popularity  :float
#  length      :float
#  playlist_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  position    :integer
#  votes_count :integer         default(0)
#  spotify_id  :string(255)
#

