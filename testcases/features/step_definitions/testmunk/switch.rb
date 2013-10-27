Then /^the switch should be on$/ do
  switch_query = query('switch', :isOn).first
  is_on = "1"

  if (is_on != switch_query)
    screenshot_and_raise "Expecting switch to be on"
  end
end

Then /^the switch should be off$/ do
  switch_query = query('switch', :isOn).first
  is_on = "0"

  if (is_on != switch_query)
    screenshot_and_raise "Expecting switch to be off"
  end
end
