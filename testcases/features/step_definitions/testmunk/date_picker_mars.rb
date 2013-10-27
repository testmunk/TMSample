require 'date'
require 'calabash-cucumber/calabash_steps'

=begin
This is a simple library written to select the Date and Time using Calabash Cucumber
Put the date_picker_mars.rb file into the step_definitions folder
Set the date using 'Then I select date "25/12/2012 03:00 AM"'
Make sure to pass in the full date.

This library was tested on iOS6, Ruby 1.9.3 and Calabash-iOS 0.9.126

@author: Testmunk
15/12/2012

UPDATED: Now supports iPhone5 + iPad as well. Does not require the 
base64 files, the touch function is used.
31/12/2012

UPDATED: Touch function was too slow, replaced with a better 
implementation which I got from Google groups. Also added 
validation in the end, fails if something goes wrong.
18/01/2013

UPDATED: Added support for other Date and Time pickers as well, 
also added a new step for selecting just time 'Then I select time 
"11:30 PM"'. Still need to implement the countdown and min/max date
- Also added support for dynamic minute intervals
07/02/2013

=end

# pause between animations since they are async
SLEEP_TIME = 0.4

# only supports 12hr mode atm
$is24hr = false;

# picker modes
UIDatePickerModeTime = 0
  # This mode has 3 columns Hour/Minute/AM:PM
  # This will have 2 columns if date is set in 24 hour mode
  # Hour cycles between 1-12 [row:0 select 1]
  # Min cyles between 00-60 [row:0 is 00]
  
UIDatePickerModeDate = 1
  # 3 columns Month (in full words) / Day / Year
  # Month between Jan-Dec, row:0 is Jan
  # Date between 1-31 (greys out if not applicable)
    # row: 0 is 1
  # Year row:0 is 1,
   
UIDatePickerModeDateAndTime = 2
  # already implemented
  
# UIDatePickerModeCountDownTimer = 3
  # 2 columns hour / min
  # Hour row:0 is 0
  # min row: 0 is 0 (greys out on Hour=0)

def perform_selection(rowNumber, colNumber) 
  query("view:'_UIDatePickerView'", [{:selectRow => rowNumber}, {:inComponent => colNumber}, {:animated => 0}])
  query("pickerView", :delegate, [{:pickerView => :__self__}, {:didSelectRow => rowNumber}, {:inComponent => colNumber}])
  sleep(SLEEP_TIME)
end

def set_date(date_to_reach,col) 
  # row 0 is 1876-02-26 (18/01), 1876-03-02 (24/01)
  # The first row is kind of dynamic
  # Since we have to select row number, we get that
  # by subtracting date on row 0 with expected date
  $i = date_to_reach - DateTime.parse("1876-02-26")  
  $i -= (DateTime.now - DateTime.parse("2013-01-18")).to_i
  perform_selection($i.to_i + 1,col)   
    
end

def set_month(date_to_reach, col)
  perform_selection(date_to_reach.month - 1, col)
end

def set_day(date_to_reach, col)
  perform_selection(date_to_reach.day - 1, col)  
end

def set_year(date_to_reach, col)
  perform_selection(date_to_reach.year - 1, col)  
end

def set_hour(date_to_reach,col) 
  $hour = date_to_reach.hour;
  if($hour <= 1) 
    $hour = 12 
  end
  perform_selection($hour - 1,col)
end

def set_min(date_to_reach,col) 
  $min = date_to_reach.strftime("%M").to_i
  $minInterval = query("datePicker", :minuteInterval).first
  if($min % $minInterval != 0) 
    screenshot_and_raise 'Minutes entered cannot be selected! Current picker ' +
      'has interval of ' + $minInterval.to_s
  end   
  perform_selection($min / $minInterval,col)
end

def set_meridian(date_to_reach,col)
  $i = 0
  if(date_to_reach.strftime("%p") == "PM") 
    $i = 1
  end  
  perform_selection($i,col)  
end  

def set_picker_mode(col) 
  #checking if picker mode is in 24 hours or not
  if(query("pickerTableView index:" + col).empty?)
    $is24hr = true
    screenshot_and_raise 'Picker is currently in 24 hour mode,' +
      ' please turn this off from the Settings on the device'
  end   
  puts('Picker is '+ ($is24hr ? '' : 'not ') +'currently in 24 hour mode')
end

def select_date_on_datetime(date_string)
  
  date_to_reach = DateTime.parse(date_string)
  result_date_pattern = ""
  case query("datePicker", :datePickerMode).first
  when UIDatePickerModeTime
    set_picker_mode('2') 
    set_hour(date_to_reach,0)
    set_min(date_to_reach,1)
    set_meridian(date_to_reach,2)
    result_date_pattern = "%H:%M"
  when UIDatePickerModeDate
    set_month(date_to_reach, 0)
    set_day(date_to_reach, 1)
    set_year(date_to_reach, 2)
    result_date_pattern = "%d-%b-%Y"
  when UIDatePickerModeDateAndTime
    set_picker_mode('3') 
    set_hour(date_to_reach,1)
    set_min(date_to_reach,2)
    set_meridian(date_to_reach,3)
    set_date(date_to_reach,0)
    result_date_pattern = "%d-%b-%Y %H:%M"
  else
    screenshot_and_raise 'Unable to identify picker mode' +
      ' only Date, Time and DateAndTime pickers supported.'
  end
 
  date = DateTime.parse(query("datePicker", "date").first)
  if(date_to_reach.strftime(result_date_pattern) != date.strftime(result_date_pattern))
    screenshot_and_raise 'Unable to set date correctly! expected: ' +
                            date_to_reach.strftime("%d-%m-%Y %H:%M") + 
                            ' got:' + date.strftime("%d-%m-%Y %H:%M")
  end
end

Then /^I select date "(.*?)"$/ do |sel_date|
   select_date_on_datetime(sel_date)
end

Then /^I select time "(.*?)"$/ do |sel_time|
  select_date_on_datetime(sel_time)
end