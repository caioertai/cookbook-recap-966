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
      @recipes << Recipe.new(row)
    end
  end
end
