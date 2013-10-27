Then /^I (?:press|touch) the alert button marked "([^\"]*)"$/ do |var|
  touch("alertButton marked:'#{var}'")
end
