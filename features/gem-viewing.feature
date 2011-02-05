Feature: Viewing Gems

  Scenario: Basic viewing
    Given a rubygem exists with the attributes:
      | name        | devise                                                 |
      | info        | Flexible authentication solution for Rails with Warden |
      | version     | 1.1.5                                                  |
    And a gem has been added with the attributes:
      | name | devise                      |
      | tags | auth, authentication, login |

    When I visit the page for that gem
    Then I should see "devise"
    And I should see "Flexible authentication solution for Rails with Warden"
    And I should see "1.1.5"
    And I should see "auth"
    And I should see "authentication"
    And I should see "login"
    And I should see "View at RubyGems.org"