Feature: Editing Gems

  Scenario: Adding tags
    Given a rubygem exists with the attributes:
      | name | devise |
    And a gem has been added with the attributes:
      | name | devise                      |
      | tags | auth, authentication, login |

    When I visit the page for that gem
    And I fill in text box with "users" within tags
    And I press "Add"
    Then I should see "users" within tags