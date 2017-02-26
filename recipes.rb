# Pseudocode
# 1) Ask user for filter
# 2) Show recipes
# 3) User selects recipes
# 4) Show ingredients
# * Additional features: Multiple recipes selection, add a recipe, edit a recipe

require 'sqlite3'

recipes_db = SQLite3::Database.new("recipes.db")
recipes_db.results_as_hash = true

puts "Please choose a metric to filter recipes by: "
puts "t: type (entree, dessert, etc.)
w: website/blog
v: vegan meals only
c: cook time (you will enter max cook time next)
n: no filter"


puts(recipes_db.execute("SELECT * FROM recipes"))