class Router
  def initialize(controller)
    @controller = controller
    @running = true
  end

  def run
    puts "Welcome to the cookbook"
    while @running
      display_menu
      dispatch
    end
  end

  private

  def display_menu
    puts "1. List all Recipes"
    puts "2. Add a Recipe"
    puts "3. Remove Recipe"
    puts "4. Mark a Recipe as done"
    puts "5. Import from AllRecipes.com"
    puts "0. To quit"
  end

  def dispatch
    user_input = gets.chomp.to_i
    print `clear`
    case user_input
    when 1 then @controller.list
    when 2 then @controller.create
    when 3 then @controller.destroy
    when 4 then @controller.mark
    when 5 then @controller.import
    when 0 then @running = false
    else
      puts "Invalid option"
    end
  end
end
