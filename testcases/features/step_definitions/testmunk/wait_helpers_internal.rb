require 'timeout'

def wait_for_no_error(options_or_timeout=
    {:timeout => 10,
     :retry_frequency => 0.2,
     :post_timeout => 0.1,
     :timeout_message => "",
     :screenshot_on_error => false}, &block)
  #note Hash is preferred, number acceptable for backwards compat
  timeout=options_or_timeout
  post_timeout=0.1
  retry_frequency=0.2
  timeout_message = nil
  screenshot_on_error = false

  if options_or_timeout.is_a?(Hash)
    timeout = options_or_timeout[:timeout] || 10
    retry_frequency = options_or_timeout[:retry_frequency] || 0.2
    post_timeout = options_or_timeout[:post_timeout] || 0.1
    timeout_message = options_or_timeout[:timeout_message]
    screenshot_on_error = options_or_timeout[:screenshot_on_error] || false
  end

  begin
    Timeout::timeout(timeout) do
      sleep(retry_frequency) until yield
    end
    sleep(post_timeout) if post_timeout > 0
  rescue Timeout::Error => e # ignore timeout error
  rescue Exception => e # ignore exception
  end
end

#options for wait_for apply
def wait_for_elements_exist_no_error(elements_arr, options={})
  wait_for_no_error(options) do
    elements_arr.all? { |q| element_exists(q) }
  end
end


# Internal wait steps => Ff timeout occurs no wait error / exception is thrown.
WAIT_TIMEOUT_NO_ERROR = 30.to_f

Then /^I wait to see "([^\"]*)" without error message$/ do |expected_mark|
  wait_for_elements_exist_no_error( [ "view marked:'#{expected_mark}'" ], :timeout => WAIT_TIMEOUT_NO_ERROR)
end

Then /^I wait for the "([^\"]*)" (?:input|text) field without error message$/ do |placeholder|
  wait_for_elements_exist_no_error([ "textField placeholder:'#{placeholder}'" ], :timeout => WAIT_TIMEOUT)
end

Then /^I wait to see button number (\d+) without error message$/ do |index|
  wait_for_elements_exist_no_error("button index:{index-1}", :timeout => WAIT_TIMEOUT_NO_ERROR)
end