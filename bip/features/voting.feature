Feature: Voting
  In order to vote for a song I like
  As a user
  I want to be able to vote on a specific song.

  Scenario: Voting for a song
    Given I am on the homepage
    When I click "Playlist 1"
    And I click "Vote"
    Then I should ...