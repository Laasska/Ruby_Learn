require 'open-uri'
require 'nokogiri'

url= 'https://trello-attachments.s3.amazonaws.com/5d5662bbd2d69644c04fc159/5d5662bbd2d69644c04fc17c/x/e313b72af0cbb3c4040ac5fcd3611a66/mddrive.xml'
html = open(url)
doc = Nokogiri::XML(html)

names = []
path= doc.xpath('//template')
path.each   do |main_node|
            names.push main_node.attr('name')
            puts main_node.attr('name')
            end
#File.open('results_task1.txt','w') do |i| i.puts(names) end
