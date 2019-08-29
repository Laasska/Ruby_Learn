require_relative 'connect.rb'
require_relative 'menu.rb'

#Точка входа в программу
flag = true
while flag do
    flag2 = true
    system('clear')
    print "\nMenu\n\n1) Adding records\n2) Selecting records\n3) Update records\n4) Deleting records\n0) Exit\nSelected action -> "
    case menu = gets.chomp
    when '1' 
        Menu.add_row
    when '2'
        Menu.select_row(flag2)
    when '3'
        Menu.update_row(flag2)
    when '4'
        Menu.delete_row(flag2)
    when '0'
        flag = Menu.exit(flag)
    else
        puts "This command is uncorrect! Please press enter and try again."
        gets
    end
end
