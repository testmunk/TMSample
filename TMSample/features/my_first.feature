Feature: Running a test
  As an iOS developer
  I want to have a sample feature file
  So I can begin testing quickly

Scenario: Login
  Given I am on the Welcome Screen
  Then I touch the "Email" input field
  Then I use the keyboard and type "test@testname.com"
  Then I touch the "Password" input field
  Then I use the keyboard and type "testmunk"
  Then I touch "SIGN IN"
  Then I wait
  Then I should see "Hello world"


Scenario: Wrong login
  Given I am on the Welcome Screen
  Then I touch the "Email" input field
  Then I use the keyboard and type "test@testname.com"
  Then I touch the "Password" input field
  Then I use the keyboard and type "test"
  Then I touch "SIGN IN"
  Then I should see "Invalid password!"


Scenario: Login touch menu
  Given I log in
  Then I touch "Skip"
  Then I touch the "iconSlide" button
  Then I should see "Section One"


Scenario: Check Image
  Given I log in
  Then I touch "Skip"
  Then I touch the "iconSlide" button
  Then I touch "Photos"
  Then I touch "Drop on a leaf"
  Then I should see text containing "A very long"


  Scenario: Tableview
    Given I log in
    Then I touch "Skip"
    Then I touch the "Plain Table" button
    Then I wait
    Then I scroll down
    Then I touch "Section 6 Row 0"
    Then I should see "Back"





