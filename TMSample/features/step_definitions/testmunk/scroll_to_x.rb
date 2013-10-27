Then /^I scroll (left|right|up|down) until I see "([^"]*)" limit (\d+)$/ do |dir,name,limit|
  if (not element_exists("view marked:'#{name}'"))
    count = 0
    begin
      scroll("scrollView index:0", dir)
      sleep(STEP_PAUSE)
      count = count + 1
    end while ((not element_exists("view marked:'#{name}'")) and count < limit.to_i)
  end
  scroll("scrollView index:0", dir)
end

Then /^I scroll down ([^\"]*) times?$/ do |s|
  def is_num?(str)
    Integer(str)
  rescue ArgumentError
    false
  else
    true
  end
  
  numLookup = {"one" => 1, "two" => 2, "three" => 3,  "four" => 4, "five" => 5, "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9, "ten" => 10, "eleven" => 11, "twelve" => 12,  "thirteen" => 13, "fourteen" => 14, "fifteen" => 15, "sixteen" => 16, "seventeen" => 17, "eighteen" => 18, "nineteen" => 19, "twenty" => 20}
  num = is_num?(s) ? s.to_i : numLookup[s]
  num.times { macro 'I scroll down' }
end