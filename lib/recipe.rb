class Recipe
  attr_reader :name, :description, :prep_time

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] # boolean true/false
  end

  def done? # return booleans
    @done
  end

  def mark_as_done! # change variables
    @done = true
  end

  def to_a
    [@name, @description, @prep_time, @done]
  end

  def self.headers
    %w[name description prep_time done]
  end
end
