Given /^I am on the Welcome Screen$/ do
  element_exists("view")
  sleep(STEP_PAUSE)
end


Given /^I log in$/ do
macro 'I am on the Welcome Screen'
macro 'I touch the "Email" input field'
macro 'I use the keyboard and type "test@testname.com"'
macro 'I touch the "Password" input field'
macro 'I use the keyboard and type "testmunk"'
macro 'I touch done'
#macro 'I touch the "SIGN IN" button'
end