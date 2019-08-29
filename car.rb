require_relative 'methods.rb'

class Car < Methods
    attr_accessor :mark,:model,:color,:weight,:tpe,:date,:id,:price
    #Метод определения id новой записи
    def self.id
    tmp = ActiveRecord::Base.connection.execute("select id from cars order by cars.id desc limit 1")
    if tmp.cmd_tuples == 0
        return 1
    else
        return (tmp.getvalue(0,0)+1)
    end
    end
    #Инициализация объекта класса
    def initialize(options)
        @id     = Car.id
        @mark   = options[:mark]
        @model  = options[:model]
        @color  = options[:color]
        @weight = options[:weight]
        @tpe    = options[:tpe]
        @date   = options[:date]
        @price  = options[:price]
    end
    #Метод сохранения новой записи в таблицу
    def self.save(car)
    ActiveRecord::Base.connection.execute("insert into cars (id, mark, model, color, weight, tpe, date, price) values ( '#{car.id}','#{car.mark}', '#{car.model}', '#{car.color}', '#{car.weight}', '#{car.tpe}', '#{car.date}', #{car.price})")
    end
    #Метод отображения всех записей таблицы
    def self.view_all_cars
        row = ActiveRecord::Base.connection.execute("select * from cars order by id")
        system('clear')
        puts "\nTable 'Cars'\n\n id |  mark  |  model  |  color  | weight |    type    | year | price "
        puts "----+--------+---------+---------+--------+------------+------+-------+"
        j = 0
        row.each {
        printf ' ' + row.getvalue(j,0).to_s.ljust(3)  + '|'
        printf ' ' + row.getvalue(j,1).to_s.ljust(7)  + '|'
        printf ' ' + row.getvalue(j,2).to_s.ljust(8)  + '|'
        printf ' ' + row.getvalue(j,3).to_s.ljust(8)  + '|'
        printf row.getvalue(j,4).to_s.center(8) + '|'
        printf row.getvalue(j,5).to_s.center(12)+ '|'
        printf row.getvalue(j,6).to_s.center(6) + '|'
        printf row.getvalue(j,7).to_s.center(7) + '|'
        j+=1
        puts ''}
    end
    #Метод отображения записей выборки из таблицы
    def self.view(row)
        system('clear')
        puts "\nTable 'Cars'\n\n id |  mark  |  model  |  color  | weight |    type    | year | price "
        puts "----+--------+---------+---------+--------+------------+------+-------+"
        j = 0
        row.each {
        printf ' ' + row.getvalue(j,0).to_s.ljust(3)  + '|'
        printf ' ' + row.getvalue(j,1).to_s.ljust(7)  + '|'
        printf ' ' + row.getvalue(j,2).to_s.ljust(8)  + '|'
        printf ' ' + row.getvalue(j,3).to_s.ljust(8)  + '|'
        printf row.getvalue(j,4).to_s.center(8) + '|'
        printf row.getvalue(j,5).to_s.center(12)+ '|'
        printf row.getvalue(j,6).to_s.center(6) + '|'
        printf row.getvalue(j,7).to_s.center(7) + '|'
        j+=1
        puts ''}
        tmp = ActiveRecord::Base.connection.execute("select count(*) from cars")
        puts "\nSelected #{j} out of #{tmp.getvalue(0,0).to_s} records in table\n"         
    end
    #метод отображения оставшихся записей таблциы после удаления
    def self.view_delete(row)
        system('clear')
        j = 0
        temp_array = []
        row.each {
            temp_array[j] = row.getvalue(j,0) 
            j+=1 }
        tmp  = (ActiveRecord::Base.connection.execute("select count(*) from cars")).getvalue(0,0)
        temp_array.each { |id| ActiveRecord::Base.connection.execute("delete from cars where id = #{id}") }
        puts "\nTable 'Cars'\n\n id |  mark  |  model  |  color  | weight |    type    | year | price "
        puts "----+--------+---------+---------+--------+------------+------+-------+"
        i = 0
        view = ActiveRecord::Base.connection.execute("select * from cars order by id")
        view.each {
        printf ' ' + view.getvalue(i,0).to_s.ljust(3)  + '|'
        printf ' ' + view.getvalue(i,1).to_s.ljust(7)  + '|'
        printf ' ' + view.getvalue(i,2).to_s.ljust(8)  + '|'
        printf ' ' + view.getvalue(i,3).to_s.ljust(8)  + '|'
        printf view.getvalue(i,4).to_s.center(8) + '|'
        printf view.getvalue(i,5).to_s.center(12)+ '|'
        printf view.getvalue(i,6).to_s.center(6) + '|'
        printf view.getvalue(i,7).to_s.center(7) + '|'
        i+=1
        puts ''}
        puts "\nDeleted #{j} out of #{tmp} records in table\n"         
    end
    #Метод отображения необходимого столбца таблицы для выполнения выборки
    def self.view_one_field(row,param)
        system('clear')
        if param == 'tpe'
            param = 'type'
        end
        puts "\nField #{param} from table 'Cars'\n\n    #{param}"
        puts "+------------+"
        j = 0
        row.each {
        printf '|' + row.getvalue(j,0).to_s.center(12)  + '|'
        j+=1
        puts ''}
        puts "+------------+\n\n"
        tmp = ActiveRecord::Base.connection.execute("select count(*) from cars")
    end
    #Процедура выбора запроса на выборку
    def self.select(id_menu)
        case id_menu
            when '1'
                Methods.select_two_param 'year'
            when '2'
                Methods.select_one_param 'color'
            when '3'
                Methods.select_one_param 'mark'
            when '4'
                Methods.select_one_param 'model'
            when '5'
                Methods.select_two_param 'weight'
            when '6'
                Methods.select_one_param 'tpe'
            when '7'
                Methods.select_two_param 'price'
            when '8'
                Methods.select_interval 'asc'
            when '9'
                Methods.select_interval 'desc'
        end
    end
    #Процедура выбора запроса на обновления
    def self.update(id_menu)
        case id_menu
            when '1'
                Methods.update 'year'   
            when '2'
                Methods.update 'color'    
            when '3'
                Methods.update 'mark'
            when '4'
                Methods.update 'model'
            when '5'
                Methods.update 'weight'
            when '6'
                Methods.update 'type'
            when '7'
                Methods.update 'price' 
        end
    end
    #Процедура выбора запроса на удаление
    def self.delete(id_menu)
        case id_menu
            when '1'
                Methods.delete_one_param 'id'
            when '2'
                Methods.delete_two_param 'year'
            when '3'
                Methods.delete_one_param 'color'
            when '4'
                Methods.delete_one_param 'mark'
            when '5'
                Methods.delete_one_param 'model'
            when '6'
                Methods.delete_two_param 'weight'
            when '7'
                Methods.delete_one_param 'tpe'
            when '8'
                Methods.delete_two_param 'price'
            when '9'
                Methods.delete_interval 'asc'
            when '10'
                Methods.delete_interval 'desc'
        end
    end
end
