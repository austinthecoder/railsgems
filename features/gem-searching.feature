Feature: Searching Gems

  Background:
    Given rubygems exist with the attributes:
      | name      |
      | gem-one   |
      | gem-two   |
      | gem-three |
      | gem-four  |
      | gem-five  |
    And gems have been added with the attributes:
      | name      | tags               |
      | gem-one   | tag-one tag-two    |
      | gem-two   | tag-three tag-four |
      | gem-three | tag-two tag-five   |
      | gem-four  | tag-one tag-four   |
      | gem-five  | tag-one tag-four   |

  Scenario Outline: By tags
    When I go to the gems page
    And I fill in "Tags" with "<tags>"
    And I press "Search"
    And the search results should include gems "<gems>"
    And the search results should not include gems "<not gems>"

    Examples:
      | tags             | gems                                            | not gems                                        |
      |                  | gem-one, gem-two, gem-three, gem-four, gem-five |                                                 |
      | tag-one          | gem-one, gem-four, gem-five                     | gem-two, gem-three                              |
      | tag-two          | gem-one, gem-three                              | gem-two, gem-four, gem-five                     |
      | tag-three        | gem-two                                         | gem-one, gem-three, gem-four, gem-five          |
      | tag-four         | gem-two, gem-four, gem-five                     | gem-one, gem-three                              |
      | tag-five         | gem-three                                       | gem-one, gem-two, gem-four, gem-five            |
      | tag-one tag-five |                                                 | gem-one, gem-two, gem-three, gem-four, gem-five |
      | tag-one tag-four | gem-four, gem-five                              | gem-one, gem-two, gem-three                     |
      | tag-six          |                                                 | gem-one, gem-two, gem-three, gem-four, gem-five |
