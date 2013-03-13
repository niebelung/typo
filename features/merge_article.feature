Feature: Merge Articles
  As a blog administrator
  In order to merge articles 
  I want to be able to merge articles in my blog

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: A non-admin cannot merge articles

    Given
    Given I am on the new article page
    When I fill in "article_title" with "Foobar"
    And I fill in "article__body_and_extended_editor" with "Lorem Ipsum"
    And I press "Publish"
    Then I should be on the admin content page
    When I go to the home page
    Then I should see "Foobar"
    When I follow "Foobar"
    Then I should see "Lorem Ipsum"
