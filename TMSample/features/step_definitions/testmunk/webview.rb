Then /^I am on a webview and enter text "([^"]*)" into the "([^"]*)" input field$/ do | text, field_id |
    set_text "webView css:'##{field_id}'","#{text}"
end


Then /^I am on a webview and touch the "([^"]*)" button$/ do | button_id |
  touch("webView css:'##{button_id}'")
end