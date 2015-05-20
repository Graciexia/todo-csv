require 'csv'

class Todo

  def initialize(file_name)
    @file_name = file_name
    @todos = CSV.read(@file_name, headers:true)
    # You will need to read from your CSV here and assign them to the @todos variable. make sure headers are set to true
  end

  def start
    loop do
      system('clear')

      puts "---- TODO.rb ----"

      view_todos

      puts
      puts "What would you like to do?"
      puts "1) Exit 2) Add Todo 3) Mark Todo As Complete"
      print " > "
      action = gets.chomp.to_i
      case action
      when 1 then exit
      when 2 then add_todo
      when 3 then mark_todo
      else
        puts "\a"
        puts "Not a valid choice"
      end
    end
  end

  def view_todos
    view_todos_by_status("Unfinished","no")
    view_todos_by_status("Completed","yes")
  end

  def view_todos_by_status(header,status)
    puts header
    arr_name = []
    @todos.each do |x|
      if x["completed"] == status
        arr_name.push(x["name"])
      end
    end
    arr_name.each_with_index do |element, index|
      puts "#{index+1}) #{element}"
    end
  end

  # def view_todos_by_status(header,status)
  #   puts header
  #   @todos.each_with_index do |x, index|
  #     if x["completed"] == status
  #       puts "#{index+1}) #{x['name']}"
  #     end
  #   end
  # end

  def add_todo
    puts "Name of Todo > "
    name_of_todo = get_input
    @todos << [name_of_todo, "no"]
    save!
  end

  def todos
    return @todos
  end

  # def mark_todo
  #   # view_todos_by_status("Unfinished","no")
  #   puts "Which todo have you finished?"
  #   action = gets.chomp.to_i

  #   puts "finish homework,yes\n"
  #   if yes
  #     save!
  #   else
  #   end
  # end

  # def mark_todo
  #   puts "Which todo do you want to change? "
  #   action = gets.chomp.to_i
  #   # todo: check if input is in correct range
  #   if action < 1 || action > @todos.count
  #     puts "\aThat is not a valid number. Press <enter> to continue."
  #     action = gets.chomp
  #   else
  #     if @todos[action-1]["completed"] == "yes"
  #       puts "\aThat todo is already finished. Press <enter> to continue."
  #       action = gets.chomp
  #     else
  #       @todos[action-1]["completed"] = "yes"
  #     end
  #     save!
  #   end
  # end

  def mark_todo
    puts "Which todo have you finished?"
    action = get_input.to_i
    arr_index = 0
    @todos.each do |x|
      if x["completed"] == "no"
        arr_index = arr_index + 1
        if arr_index == action
          x["completed"] = "yes"
          save!
          break
        end
      end
    end
  end

  private
  def get_input
    gets.chomp
  end

  def save!
    File.write(@file_name, @todos.to_csv)
  end
end
