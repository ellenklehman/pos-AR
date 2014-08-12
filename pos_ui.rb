require 'active_record'
require './lib/product'
require './lib/cashier'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to the Point of Sale System!"
  puts "Enter your Employee ID to begin ringing up customers."
  employee_id = gets.chomp.to_i
  if employee_id > 0
    employee_menu(employee_id)
  else
    manager_menu
  end
end

def manager_menu
  choice = nil
  until choice == 'e'
    puts "Press 'a' to add a product, 'l' to list your products, 'u' to update a product 'd' to delete a product"
    puts "Press 'c' to add a cashier, 'cl' to see a list of your cashiers, 'uc' to update a cashier"
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      product_add
    when 'l'
      product_list
    when 'u'
      product_update
    when 'd'
      product_delete
    when 'c'
      add_cashier
    when 'cl'
      list_cashier
    when 'uc'
      update_cashier
    when 'e'
      puts "Good-bye!"
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def product_add
  puts "What is the name of the product?"
  product_name = gets.chomp
  puts "What is the price of the product?"
  product_price = gets.chomp.to_f
  product = Product.create({:name => product_name, :price => product_price})
  puts "'#{product_name}' has been added."
end

def product_list
  puts "Here are all of your products:"
  products = Product.all
  products.each { |product| puts "ID: #{product.id}  #{product.name} : $#{product.price}"}
end

def product_update
  list
  puts "Type in the name of the product you would like to update."
  selected_name = gets.chomp
  product = Product.find_by(:name => selected_name)
  puts "Type 'n' to update the name.  Type 'p' to update the price."
  user_choice = gets.chomp.downcase
  if user_choice == 'n'
    puts "What would you like to rename it to?"
    new_name = gets.chomp
    product.update(:name => new_name)
  elsif user_choice == 'p'
    puts "What would you like the new price to be?"
    new_price = gets.chomp
    product.update(:price => new_price)
  else
    manager_menu
  end
  puts "Product has been updated."
end

def product_delete
  list
  puts "Type in the name of the product you would like to delete."
  selected_name = gets.chomp
  product = Product.find_by(:name => selected_name)
  product.destroy
  puts "Product has been deleted."
end

def add_cashier
  puts "What is the name of the new cashier?"
  cashier_name = gets.chomp
  cashier = Cashier.create(:name => cashier_name)
end

def list_cashier
  puts "Here are all of your cashiers."
  cashiers = Cashier.all
  cashiers.each {|cashier| puts "Name: #{cashier.name}  Employee ID: #{cashier.id}"}
end

def update_cashier
  list_cashier
  puts "Type in the ID of the cashier you would like to update."
  cashier_id = gets.chomp
  cashier = Cashier.find(cashier_id)
  puts "What is the new name of this cashier?"
  cashier_name = gets.chomp
  cashier.update(:name => cashier_name)
  puts "Cashier has been updated."
end

def employee_menu(employee_id)
  choice = nil
  puts "Welcome to the POS system.  Remember to smile at your customers."
  puts "Type 'n' to ring up a new purchase, 'r' to return a product"
  puts "Type 'e' to exit"
  choice = gets.chomp
  until choice == 'e'
    case choice
    when 'n'
      new_purchase(employee_id)
    when 'r'
      return_product
    when 'e'
      puts "Good-bye!"
    else
      puts "Sorry that isn't a valid option"
    end
  end
end

def new_purchase(employee_id)
  product_list
  puts "Type in the ID of the product you would like to add to the purchase."
end
welcome














