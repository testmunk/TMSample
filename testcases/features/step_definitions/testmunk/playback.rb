Then /^I do a long press on "([^\"]*)"$/ do |name|
  playback("long_press", {:query => "view marked:'#{name}'"})
  sleep(STEP_PAUSE)
end


Then /^I do a long press on list item "(\d+)"$/ do |index|
  index = index.to_i
  playback("long_press", {:query => "TableViewCellContentView index:#{index-1}"})
  sleep(STEP_PAUSE)
end


