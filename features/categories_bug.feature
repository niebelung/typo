Feature: Merge Articles
  As a blog administrator
  In order to create and edit categories 
  I want to be able have no bugs on this functionality

  Background:
    Given the following categories exist:
  | name                   | keywords  | description |
  | Amazing                | amazing   | amazing     |


  Scenario: An admin should be able to create new categories
    Given the blog is set up
    Given I am logged into the admin panel
    Given I am on the index page for articles
    When I follow "Categories"
    Then I should be on the new category page
  
  Scenario: An admin should be able to edid existing categories
    Given the blog is set up
    Given I am logged into the admin panel
    Given I am on the edit page for "General" category
    When I fill in "Name" with "Special"
    And I press "Save"
    Then I should be on the edit page for "Special" category
    And I should see "Category was successfully saved."
  
