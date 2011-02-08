Feature: Navigation

  Scenario: About page
    When I go to the home page
    And I follow "About this site"
    Then I should see "What is this site?"