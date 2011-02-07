Feature: Editing Gems

  Scenario: Modifying tags
    Given a rubygem exists with the attributes:
      | name | devise |
    And a gem has been added with the attributes:
      | name | devise     |
      | tags | auth login |

    When I visit the page for that gem
    And I follow "edit tags"
    And I check "auth"
    And I fill in "Add tags" with "authentication users"
    And I press "Save"
    Then I should see "authentication" within tags
    And I should see "users" within tags
    And I should see "login" within tags