Feature: Adding Gems

  Scenario: Adding a gem
    When I go to the home page
    And I fill in the following:
      | Name of the gem               | devise              |
      | Tags associated with this gem | authentication auth |
    And I press "Add"
    Then I should see "Thanks for adding devise!"

    When I go to the gem's page for devise
    Then I should not see "This gem is not in our system"