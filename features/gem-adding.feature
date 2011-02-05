Feature: Adding Gems

  Scenario: Successful add
    Given a rubygem exists named "devise"

    When I go to the home page
    And I fill in the following:
      | Name of the gem               | devise               |
      | Tags associated with this gem | authentication, auth |
    And I press "Add"
    Then I should see "Thanks for adding devise!"

    When I visit the page for that gem
    Then I should not see "This gem is not in our system"


  Scenario Outline: Invalid fields
    When I go to the home page
    And I fill in "Name of the gem" with "<gem name>"
    And I press "Add"
    Then I should see "must be a combination of letters, numbers, dashes, and underscores (with at least one letter)"

    Examples:
      | gem name    |
      |             |
      | 867-897     |
      | __          |
      | -345        |
      | d.asf       |
      | oija aljdsf |
      | KLJ#8768    |


  Scenario: Gem doesn't exist
    Given a rubygem does not exist named "unknown-gem"

    When I go to the home page
    And I fill in "Name of the gem" with "unknown-gem"
    And I press "Add"
    Then I should see "That gem does not exist"


  Scenario: Gem already added
    Given a rubygem exists named "devise"

    When I go to the home page
    And I fill in the following:
      | Name of the gem | devise |
    And I press "Add"
    And I go to the home page
    And I fill in the following:
      | Name of the gem | devise |
    And I press "Add"
    Then I should see "has already been added!"