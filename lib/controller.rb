require_relative "recipe"
require_relative "view"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # Ask REPO for all recipes
    recipes = @cookbook.all
    # Ask VIEW to display them
    @view.display(recipes)
  end

  def create
    # Ask VIEW to ask user for a name
    recipe_name = @view.ask_for_string("name")
    # Ask VIEW to ask user for a description
    recipe_description = @view.ask_for_string("description")
    # Ask RECIPE to instantiate one
    new_recipe = Recipe.new(name: recipe_name, description: recipe_description)
    # Ask COOKBOOK to store it
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    # Ask REPO for all recipes
    recipes = @cookbook.all
    # Ask VIEW to display them
    @view.display(recipes)
    # Ask VIEW to ask user for a number
    recipe_index = @view.ask_for_index
    # Ask COOKBOOK to remove the recipe of that index
    @cookbook.remove_recipe(recipe_index)
  end

  # # Mark with Cookbook#mark_recipe(index)
  # def mark
  #   # Ask REPO for all recipes
  #   recipes = @cookbook.all
  #   # Ask VIEW to display them
  #   @view.display(recipes)
  #   # Ask VIEW to ask user for a number to mark
  #   recipe_index = @view.ask_for_index
  #   # Ask COOKBOOK to mark the recipe
  #   @cookbook.mark_recipe(recipe_index)
  # end

  # Mark with Cookbook#persist!
  def mark
    # Ask REPO for all recipes
    recipes = @cookbook.all
    # Ask VIEW to display them
    @view.display(recipes)
    # Ask VIEW to ask user for a number to mark
    recipe_index = @view.ask_for_index
    # Ask COOKBOOK to for the recipe
    recipe = @cookbook.find(recipe_index)
    # Ask RECIPE INSTANCE to mark itself
    recipe.mark_as_done!
    # Ask COOKBOOK to update csv???
    @cookbook.persist!
  end
end
