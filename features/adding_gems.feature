Feature: Adding Gems

  Scenario: Successful add
    When I go to the home page
    And I fill in the following:
      | Name of the gem               | devise              |
      | Tags associated with this gem | authentication auth |
    And I press "Add"
    Then I should see "Thanks for adding devise!"

    When I go to the gem's page for devise
    Then I should not see "This gem is not in our system"


  Scenario Outline: Invalid fields
    When I go to the home page
    And I fill in "Name of the gem" with "<gem name>"
    And I press "Add"
    Then I should see "<error message>"

    Examples:
      | gem name    | error message                                              |
      |             | can't be blank                                             |
      | 867-897     | must include at least one letter                           |
      | __          | must include at least one letter                           |
      | -345        | must include at least one letter                           |
      | d.asf       | can only include letters, numbers, dashes, and underscores |
      | oija aljdsf | can only include letters, numbers, dashes, and underscores |
      | KLJ#8768    | can only include letters, numbers, dashes, and underscores |


  Scenario: Gem doesn't exist
    Given the gem "unknown-gem" does not exist

    When I go to the home page
    And I fill in "Name of the gem" with "unknown-gem"
    And I press "Add"
    Then I should see "That gem does not exist"


  Scenario: Gem already added
    When I go to the home page
    And I fill in the following:
      | Name of the gem | devise |
    And I press "Add"
    And I go to the home page
    And I fill in the following:
      | Name of the gem | devise |
    And I press "Add"
    Then I should see "has already been added!"