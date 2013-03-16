Feature: Merge Articles
  As a blog administrator
  In order to merge articles 
  I want to be able to merge articles in my blog

  Background:
    Given the following articles exist:
  | title                   | body                           | author |
  | Hello World!            | Welcome to Typo. This is your first article. Edit or delete it, then start blogging!   | Mr Typo  |
  | Salut World!            | This is Salut World article!   | vasja  |
  | Goodbye World!          | This is Goodbye World article! | petja  |


  Scenario: A non-admin cannot merge articles
    Given the blog is set up for vasja
    Given I am logged into the vasja panel
    Given I am on the edit page for "Salut World!"
    Then I should not see "Merge Articles"
  
  Scenario: Input for article to merge id should have HTML name merge_with
    Given the blog is set up
    Given I am logged into the admin panel
    Given I am on the edit page for "Salut World!"
    Then "Article ID" field name should be "merge_with"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given the blog is set up
    Given I am logged into the admin panel
    Given I am on the edit page for "Salut World!"
    When I fill in "merge_with" with id of "Goodbye World!"
    And press "Merge"
    Then I should be on the edit page for "Goodbye World!"
    And I should see "This is Salut World article!"
    And I should see "This is Goodbye World article!"

  Scenario: When articles are merged, the merged article should have one of the original authors
    Given the blog is set up
    Given I am logged into the admin panel
    Given I am on the edit page for "Salut World!"
    When I fill in "merge_with" with id of "Goodbye World!"
    And press "Merge"
    Then I should be on the edit page for "Goodbye World!"
    And the author of "Goodbye World!" should be "vasja" or "petja"

  Scenario: When articles are merged, the merged article should have one of the original titles
    Given the blog is set up
    Given I am logged into the admin panel
    Given I am on the edit page for "Salut World!"
    When I fill in "merge_with" with id of "Goodbye World!"
    And press "Merge"
    Then I should be on the edit page for "Goodbye World!"
    And article title should be "Goodbye World!" or "Salut World!"

  Scenario: When articles are merged, the merged article should have all of the original comments
    Given the blog is set up
    Given I am logged into the admin panel
    Given "petja" commented "Salut World!"
    Given "vasja" commented "Goodbye World!"
    Given I am on the edit page for "Salut World!"
    When I fill in "merge_with" with id of "Goodbye World!"
    And press "Merge"
    Then "Goodbye World!" should be commented by "vasja"
    And "Goodbye World!" should be commented by "petja"
    
    
