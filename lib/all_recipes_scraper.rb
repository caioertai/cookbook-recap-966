require "open-uri"
require "nokogiri"
require_relative "recipe"

class AllRecipesScraper
  def initialize(query)
    @query = query
  end

  def call # default for service objects
    # get the url with the query
    url = "https://www.allrecipes.com/search/results/?search=#{@query}"
    # open that url
    html_string = URI.open(url).read
    # parse the page
    doc = Nokogiri::HTML.parse(html_string) # search -> [] / at => <>
    # search for each recipe attributes
    recipes = doc.search('.card__detailsContainer-left').first(5).map do |element|
      recipe_name = element.at('h3').text.strip
      recipe_description = element.at('.card__summary').text.strip
      recipe_prep_time = 10 # TODO: scrape it from the details
      Recipe.new(name: recipe_name, description: recipe_description, prep_time: recipe_prep_time)
    end
  end # return an array of recipes from AllRecipes
end
