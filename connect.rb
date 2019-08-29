require 'active_record'

#Настройка подключения программы к базе данных PostgreSQL
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'cars',
  host: 'localhost'
)
