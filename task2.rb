require 'mechanize'
require 'nokogiri'
require 'open-uri'

#this is method is Nokogiri
doc = Nokogiri::HTML(open('https://kurs.com.ru/'))
curr_usd = doc.at_css('//td[@data-rate-type="ask"]').attr('data-rate').to_f
puts '{Nokogiri}  The current dollar rate in rubles is: ' +  curr_usd.to_s

#this is method is Mechanize
mech = Mechanize.new
page = mech.get('https://kurs.com.ru/')
current = page.search('[@class="ipsKurs_currency"]')[0].attr(:title)
rate = page.search('@data-rate')[2]
puts '{Mechanize} The current ' + current + ' rate in rubles is: ' + rate.to_s
