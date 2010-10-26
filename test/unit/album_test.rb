require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
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

