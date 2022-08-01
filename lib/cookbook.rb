require "csv"
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

  private

  def update_csv
    CSV.open(@csv_path, "wb") do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description] # One row at a time
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_path) do |row|
      #              0                 1
      # row => ["Caipirinha", "Lemon and cachaca"]
      @recipes << Recipe.new(row[0], row[1])
    end
  end
end
