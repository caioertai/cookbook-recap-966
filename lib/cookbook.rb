require "csv"
require "pry-byebug"
require_relative "recipe"

class Cookbook
  def initialize(csv_path)
    @recipes = [] # Array instances of recipes
    @csv_path = csv_path
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(new_recipe)
    # Add to memory
    @recipes << new_recipe
    # Mirror the memory into the CSV
    update_csv
  end

  def remove_recipe(recipe_index)
    # Add to memory
    @recipes.delete_at(recipe_index)
    # Mirror the memory into the CSV
    update_csv
  end

  def find(recipe_index)
    @recipes[recipe_index]
  end

  def mark_recipe(recipe_index)
    recipe_to_mark = @recipes[recipe_index]
    recipe_to_mark.mark_as_done!
    update_csv
  end

  def persist!
    update_csv
  end

  private

  def update_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << Recipe.headers
      @recipes.each do |recipe|
        csv << recipe.to_a # One row at a time
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_path, headers: true, header_converters: :symbol) do |row|
      # Type Casting
      # prep_time - Integer
      # done ------ boolean
      # row => { prep_time: "5", done: "false" }
      row[:prep_time] = row[:prep_time].to_i
      row[:done] = row[:done] == 'true'
      # row => { prep_time: 5, done: false }

      @recipes << Recipe.new(row)
    end
  end
end
