Then /^I should see a checkmark in the "([^\"]*)" table cell$/ do | row_marked |

  check = query("label marked:'#{row_marked}' parent tableViewCell", 'accessoryType')
  AccessoryCheckmarkID = 3

  if check.first != AccessoryCheckmarkID
    screenshot_and_raise "There is no checkmark in the #{row_marked} table cell"
  end
end


Then /^I touch the delete button on the "([^\"]*)" table cell$/ do  | name|
  touch("tableViewCell text:'#{name}' child tableViewCellEditControl")
end


Then /^I touch the "([^\"]*)" disclosure button$/ do |row|
  touch("label marked:'#{row}' parent tableViewCell child button")
end

