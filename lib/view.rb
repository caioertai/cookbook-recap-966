class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      box = recipe.done? ? "[x]" : "[ ]"
      puts "#{box} #{index + 1}. #{recipe.name} (#{recipe.prep_time} minutes) --- #{recipe.description}"
    end
  end

  def ask_for_string(label)
    puts "What's the recipe #{label}?"
    gets.chomp
  end

  def ask_for_index
    puts "Which recipe (by number)?"
    gets.chomp.to_i - 1
  end
end
