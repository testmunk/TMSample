Feature: Running a test
  As an iOS developer
  I want to have a sample feature file
  So I can begin testing quickly

  Scenario: Login
    Given I am on the Welcome Screen
    When I touch the "Email" input field
    And I use the keyboard and type "test@testname.com"
    And I touch the "Password" input field
    And I use the keyboard and type "testmunk"
    And I touch "SIGN IN"
    And I wait
    Then I should see "Hello world"


  Scenario: Wrong login
    Given I am on the Welcome Screen
    When I touch the "Email" input field
    And I use the keyboard and type "test@testname.com"
    And I touch the "Password" input field
    And I use the keyboard and type "test"
    And I touch "SIGN IN"
    Then I should see "Invalid password!"


  Scenario: Login touch menu
    Given I log in
    When I touch "Skip"
    And I touch the "iconSlide" button
    Then I should see "Section One"


  Scenario: Check Image
    Given I log in
    When I touch "Skip"
    And I touch the "iconSlide" button
    And I touch "Photos"
    And I touch "Drop on a leaf"
    Then I should see text containing "A very long"


  Scenario: Tableview
    Given I log in
    When I touch "Skip"
    And I touch the "Plain Table" button
    And I wait
    And I scroll down
    And I touch "Section 6 Row 0"
    Then I should see "Back"





