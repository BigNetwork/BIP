Feature: Adding songs
  In order to listen to a song I like
  As a user
  I want to add a song to the playlist

  Scenario: Add a song to a playlist
    Given I am on the homepage
    When I click "Playlist 1"
    And I click "Add a song"
	And I fill in "Search" with "Coldplay - You"
	And I press "Search"
	And I click "Add Coldplay - You"
    Then I should see "Coldplay - You"
  
  
  
