require_relative 'car.rb'

class Menu < Car 
    #Процедура для создания записи и ее сохранения в таблицу
    def self.add_row
        system('clear') 
        Car.view_all_cars
        flag = true
        while flag
            puts "\nAdding record   (Hint: if you change your mind to add a car, write quit)\n"
            print "enter mark: "
            mark = gets.chomp
            break if mark == "quit"
            if mark == '' 
                mark = 'empty' 
            end
            print "enter model: "
            model = gets.chomp
            break if model == "quit"
            if model == '' 
                model = 'empty' 
            end
            print "enter color: "
            color = gets.chomp
            break if color == "quit"
            if color == '' 
                color = 'empty' 
            end
            print "enter weight: "
            weight = gets.chomp
            break if weight == "quit"
            unless weight.is_number? 
                weight = 0 
            end
            print "enter type: "
            type = gets.chomp
            break if type == "quit"
            if type == '' 
                type = 'empty' 
            end
            print "enter year: "
            year = gets.chomp
            break if year == "quit"
            unless year.is_number? 
                year = 0 
            end
            print "enter price: "
            price = gets.chomp
            break if price == "quit"
            unless price.is_number?
                price = 0 
            end
            car = Car.new({:mark => mark,:model => model,:color => color,:weight => weight,:tpe => type,:date => year,:price => price})
            puts "Press enter to save..."
            tmp = gets.chomp
            if tmp != 'quit' 
                Car.save(car)
                system('clear')
                Car.view_all_cars
                puts "Press enter to back to the menu..."
                flag = false
                gets
            elsif tmp == 'quit'
                break
            end
        end
    end
    #Процедура выбора требуемой выборки по нужному полю
    def self.select_row(flag2)
        while flag2 do 
            system('clear')
            print "\nSelecting records\n\n1) Year\n2) Color\n3) Mark\n4) Model\n5) Weight\n6) Type\n7) Price\n8) First records\n9) Last records\n0) Back to menu\nSelected action -> "
            case submenu_select = gets.chomp
            when '1'..'9' 
                Car.select(submenu_select)
            when '0' 
                flag2 = false
            else 
                puts "This command is uncorrect! Please press enter and try again."
                gets
            end
        end
    end
    #Процедура выбора требуемого обновления по нужному полю
    def self.update_row(flag2)
        while flag2 do 
            system('clear')
            print "\nUpdating records\n\n1) Year\n2) Color\n3) Mark\n4) Model\n5) Weight\n6) Type\n7) Price\n0) Back to menu\nSelected action -> "
            case submenu_update = gets.chomp
            when '1'..'7'
                Car.update(submenu_update)
            when '0' 
                flag2 = false
            else 
                puts "This command is uncorrect! Please press enter and try again."
                gets
            end
        end
    end
    #Процедура выбора требуемого удаления по нужному полю
    def self.delete_row(flag2)
        while flag2 do 
            system('clear')
            print "\nDeleting records\n\n1) ID\n2) Year\n3) Color\n4) Mark\n5) Model\n6) Weight\n7) Type\n8) Price\n9) First\n10) Last\n0) Back to menu\nSelected action -> "
            case submenu_delete = gets.chomp
            when '1'..'10'
                Car.delete(submenu_delete)
            when '0' 
                flag2 = false
            else 
                puts "This command is uncorrect! Please press enter and try again."
                gets
            end
        end
    end
    #Процедура выхода из программы
    def self.exit(flag)
        puts "GoodBye!"
        sleep(0.8)
        system('clear')
        return flag = false
    end
end
