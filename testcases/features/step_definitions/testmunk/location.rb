Given /^I am (?:in|at) "([^\"]*)"$/ do    | location |

  set_location(:place => "#{location}")

end


Then /^I touch the "([^\"]*)" pin$/ do |pin|
  def touch_pin(title)
    index = query("view:'MKPinAnnotationView'", :annotation,:title).index(title)
    touch("view:'MKPinAnnotationView' index:#{index}")
  end

  touch_pin pin

end
