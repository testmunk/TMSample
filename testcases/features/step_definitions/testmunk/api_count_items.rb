Then /^I compare rows on screen([^\"]*)? equals to "([^\"]*)" by key "([^\"]*)"([^\"]*)?$/ do |factorApp,uri,key,factorApi|
  require 'net/http'
  require 'uri'
  require 'rubygems'
  require 'json'
  
  def open(uri)
    Net::HTTP.get(URI.parse(uri))
  end
  
  def is_num?(str)
    Integer(str)
  rescue ArgumentError
    false
  else
    true
  end
  
  def getJsonVale(json, key)
    keyLevel = key.split('.').count.to_i
    print keyLevel
    keyArray = key.split('.').map {|s| is_num?(s) ? s.to_i : s}
      
    print keyArray
    if keyLevel == 1
      json[key]
    elsif keyLevel == 2
      json[keyArray[0]][keyArray[1]]
    elsif keyLevel == 3
      json[keyArray[0]][keyArray[1]][keyArray[2]]    
    elsif keyLevel == 4
      json[keyArray[0]][keyArray[1]][keyArray[2]][keyArray[3]]
    elsif keyLevel == 5
      json[keyArray[0]][keyArray[1]][keyArray[2]][keyArray[3]][keyArray[4]]
    elsif keyLevel == 6
      json[keyArray[0]][keyArray[1]][keyArray[2]][keyArray[3]][keyArray[4]][keyArray[5]]
    elsif keyLevel == 7
      json[keyArray[0]][keyArray[1]][keyArray[2]][keyArray[3]][keyArray[4]][keyArray[5]][keyArray[6]]
    elsif keyLevel == 8
      json[keyArray[0]][keyArray[1]][keyArray[2]][keyArray[3]][keyArray[4]][keyArray[5]][keyArray[6]][keyArray[7]]
    elsif keyLevel == 9
      json[keyArray[0]][keyArray[1]][keyArray[2]][keyArray[3]][keyArray[4]][keyArray[5]][keyArray[6]][keyArray[7]][keyArray[8]]
    elsif keyLevel == 10
      json[keyArray[0]][keyArray[1]][keyArray[2]][keyArray[3]][keyArray[4]][keyArray[5]][keyArray[6]][keyArray[7]][keyArray[8]][keyArray[9]]
    end   
  end
  
  # retrieve count of api call
  apiResult = open(uri)
  apiJson = JSON.parse(apiResult)
  opApi = factorApi ? factorApi[1] : "*"
  numApi = factorApi ? factorApi[3..-1].to_i : 1
  apiCount = if opApi == "*"
    getJsonVale(apiJson, key).to_i * numApi
  elsif opApi == "+"
    getJsonVale(apiJson, key).to_i + numApi
  elsif opApi == "-"
    getJsonVale(apiJson, key).to_i - numApi
  else
    getJsonVale(apiJson, key).to_i
  end
  
  # retrieve rows of app
  opApp = factorApp ? factorApp[1] : "*"
  numApp = factorApp ? factorApp[3..-1].to_i : 1
  rows = if opApp == "*"
    query("tableView","numberOfRowsInSection"=>0).first.to_i * numApp
  elsif opApp == "+"
    query("tableView","numberOfRowsInSection"=>0).first.to_i + numApp
  elsif opApp == "-"
    query("tableView","numberOfRowsInSection"=>0).first.to_i - numApp
  else
    query("tableView","numberOfRowsInSection"=>0).first.to_i
  end

  if rows != apiCount
    screenshot_and_raise "Number of items is not correct. Items in app: " + rows.to_s + ", items api call: " + apiCount.to_s
  end
end

