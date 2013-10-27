Then /^I (?:press|touch) the search (?:field|bar)$/ do
  touch("SearchBar")
  sleep(STEP_PAUSE)
end