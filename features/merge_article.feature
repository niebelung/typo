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

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given the blog is set up
    Given I am logged into the admin panel
    Given I am on the edit page for "Salut World!"
    When I fill in "merge_with" with id of "Goodbye World!"
    And press "Merge"
    Then I should be on the edit page for "Goodbye World!"
    And I should see "This is Salut World article!"
    And I should see "This is Goodbye World article!"

    
