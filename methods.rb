class Methods
    #Метод выборки строк из таблицы по одночному параметру (марка, модель, цвет, тип)
    def self.select_one_param(param)
        system('clear')
        row = ActiveRecord::Base.connection.execute("select #{param} from cars group by #{param} order by #{param}")
        Car.view_one_field row,param
        if param == 'tpe'
            param = 'type'
        end
        puts "This query selects all cars with the user-specified #{param}"
        print "enter #{param}: "
        if param == 'type'
            param = 'tpe'
        end
        param_user = gets.chomp
        row = ActiveRecord::Base.connection.execute("select * from cars where #{param} = '#{param_user}' order by id")            
        Car.view(row)              
        puts "Query is completed. Press enter to back to the menu..."
        gets
    end
    #Метод выборки строк из начала/конца таблицы
    def self.select_interval(param)
        system('clear')
        if param == 'asc'
            puts "This query selects as many cars from the top of the list as the user specified"
        else
            puts "This query selects as many cars from the bottom of the list as the user specified"
        end
        print "enter the number of cars: "
        param_number = gets.chomp
        unless param_number.is_number?
            param_number = '0'
        end
        row = ActiveRecord::Base.connection.execute("select * from cars order by id #{param} limit #{param_number}")            
        Car.view(row)              
        puts "Query is completed. Press enter to back to the menu..."
        gets
    end
    #Метод выборки строк из таблицы по двойному параметру (год, цена, вес)
    def self.select_two_param(param)
        system('clear')
        puts "This query selects all cars between x #{param} and y #{param}"
        min = ActiveRecord::Base.connection.execute("select #{param} from cars order by #{param} asc limit 1").getvalue(0,0)
        max = ActiveRecord::Base.connection.execute("select #{param} from cars order by #{param} desc limit 1").getvalue(0,0)
        print "enter first #{param}: "
        param_x = gets.chomp
        print "enter second #{param}: "
        if param == "year"
            param = "date"
        end
        param_y = gets.chomp
        if (param_x.to_i < min) && (param_y.to_i < min)
            param_x = '0'
            param_y = '0'
        elsif (param_x.to_i > max) && (param_y.to_i > max)
            param_x = (max.to_i+1).to_s
            param_y = (max.to_i+1).to_s
        else 
            if param_x.to_i < min
                param_x = min.to_s
            elsif param_x.to_i > max
                param_x = max.to_s
            end
            if param_y.to_i < min
                param_y = min.to_s
            elsif param_y.to_i > max
                param_y = max.to_s
            end 
        end
        if param_x < param_y 
            row = ActiveRecord::Base.connection.execute("select * from cars where #{param} between #{param_x} AND #{param_y} order by id")
        else
            row = ActiveRecord::Base.connection.execute("select * from cars where #{param} between #{param_y} AND #{param_x} order by id") 
        end            
        Car.view(row)              
        puts "Query is completed. Press enter to back to the menu..."
        gets    
    end
    #Метод обновления информации по определенному полю указанной пользователем строки
    def self.update(param)
        flag = true
        while flag
            system('clear')
            puts "This query updates information about the #{param} of the car selected by the user"
            Car.view_all_cars
            print "\nenter id of the car: "
            id = gets.chomp
            if id == '' 
                id = 0
            end
            if ((ActiveRecord::Base.connection.execute("select (select id from cars where id = #{id}) as id")).getvalue(0,0))!=nil 
                print "enter a new #{param} of the car: "
                if param == 'type'
                    param = 'tpe'
                end
                if param == 'year'
                    param = 'date'
                end
                last_param = (ActiveRecord::Base.connection.execute("select #{param} from cars where id = #{id}")).getvalue(0,0)
                new_param = gets.chomp
                if param == 'date' || param == 'weight' || param == 'price'
                    unless new_param.is_number?
                        new_param = last_param
                    end 
                end 
                ActiveRecord::Base.connection.execute("update cars set #{param} = '#{new_param}' where id = #{id}")
                Car.view_all_cars
                if param == 'type'
                    param = 'tpe'
                end
                if param == 'year'
                    param = 'date'
                end
                puts "\nSelected record with id #{id} change #{param} from #{last_param} to #{new_param}\n"
                puts "Query is completed. Press enter to back to the menu..."
                gets
                flag = false
            else
                print "id not found. press enter and try again or press 0 and back to previous menu: "
                if gets.chomp == '0' 
                    flag = false
                end 
            end
        end
    end
    ##Метод удаления строки из таблицы по одночному параметру (id, марка, модель, цвет, тип)
    def self.delete_one_param(param)
        system('clear')
        row = ActiveRecord::Base.connection.execute("select #{param} from cars group by #{param} order by #{param}")
        Car.view_all_cars
        if param == 'tpe'
            param = 'type'
        end
        puts "This query delete all cars with the user-specified #{param}"
        print "enter #{param}: "
        if param == 'type'
            param = 'tpe'
        end
        param_user = gets.chomp
        if param == 'id' || param == 'date' || param == 'weight' || param == 'price'
            unless param_user.is_number?
                param_user = 0
            end 
        elsif
            if param_user == ""
                param_user = "unknown parametr"
            end
        end
        row = ActiveRecord::Base.connection.execute("select * from cars where #{param} = '#{param_user}' order by id")            
        Car.view_delete(row)
        puts "Query is completed. Press enter to back to the menu..."
        gets
    end
    ##Метод удаления строк из начала/конца таблицы
    def self.delete_interval(param)
        system('clear')
        Car.view_all_cars
        if param == 'asc'
            puts "\nThis query delete as many cars from the top of the list as the user specified"
        else
            puts "\nThis query delete as many cars from the bottom of the list as the user specified"
        end
        print "enter the number of cars: "
        param_number = gets.chomp
        unless param_number.is_number?
            param_number = 0
        end
        row = ActiveRecord::Base.connection.execute("select * from cars order by id #{param} limit #{param_number}")            
        Car.view_delete(row)              
        puts "Query is completed. Press enter to back to the menu..."
        gets
    end
    #Метод выборки строк из таблицы по двойному параметру (год, цена, вес)
    def self.delete_two_param(param)
        system('clear')
        Car.view_all_cars
        puts "This query delete all cars between x #{param} and y #{param}"
        print "enter first #{param}: "
        param_x = gets.chomp
        print "enter second #{param}: "
        if param == "year"
            param = "date"
        end
        min = ActiveRecord::Base.connection.execute("select #{param} from cars order by #{param} asc limit 1").getvalue(0,0)
        max = ActiveRecord::Base.connection.execute("select #{param} from cars order by #{param} desc limit 1").getvalue(0,0)
        param_y = gets.chomp
        if (param_x.to_i < min) && (param_y.to_i < min)
            param_x = '0'
            param_y = '0'
        elsif (param_x.to_i > max) && (param_y.to_i > max)
            param_x = (max.to_i+1).to_s
            param_y = (max.to_i+1).to_s
        else 
            if param_x.to_i < min
                param_x = min.to_s
            elsif param_x.to_i > max
                param_x = max.to_s
            end
            if param_y.to_i < min
                param_y = min.to_s
            elsif param_y.to_i > max
                param_y = max.to_s
            end 
        end
        if param_x < param_y 
            row = ActiveRecord::Base.connection.execute("select * from cars where #{param} between #{param_x} AND #{param_y} order by id")
        else
            row = ActiveRecord::Base.connection.execute("select * from cars where #{param} between #{param_y} AND #{param_x} order by id") 
        end            
        Car.view_delete(row)              
        puts "Query is completed. Press enter to back to the menu..."
        gets    
    end
end

#Метод для класса Object, чтобы проверить объект число или нет
class Object
  def is_number?
    to_f.to_s == to_s || to_i.to_s == to_s
  end
end
