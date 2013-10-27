Then /^I use the keyboard and type "([^\"]*)"$/ do | input |
  keyboard_enter_text input
  sleep(STEP_PAUSE)
end


Then /^I use the keyboard to generate a random user "([^\"]*)"$/ do | input |
  numa = rand(900000).to_s
  print numa
  keyboard_enter_text numa.to_s+input
end


Then /^I touch delete$/ do
  keyboard_enter_char "Delete"
end


Then /^I should see the keyboard$/ do
  res = element_exists('keyboardAutomatic')
  unless res
    screenshot_and_raise 'Expected keyboard to be visible.'
  end

end


Then /^I should not see the keyboard$/ do
  res = element_exists('keyboardAutomatic')
  if res
    screenshot_and_raise 'Expected keyboard to not be visible.'
  end
end
