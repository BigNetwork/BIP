require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: artists
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  spotify_id :string(255)
#  created_at :datetime
#  updated_at :datetime
#

