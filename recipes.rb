# Pseudocode
# 1) Ask user for filter
# 2) Show recipes
# 3) User selects recipes
# 4) Show ingredients
# * Additional features: Multiple recipes selection, add a recipe, edit a recipe

require 'sqlite3'

recipes_db = SQLite3::Database.new("recipes.db")
recipes_db.results_as_hash = true

valid_filter = false

while valid_filter == false

	puts "Please choose a metric to filter recipes by: " 
	puts "t: type (entree, dessert, etc.)
	s: source (website/blog)
	v: vegan meals only
	c: cook time (you will enter max cook time next)
	n: no filter"

	user_filter = gets.chomp

	if user_filter == "t" || user_filter == "T"
		valid_filter = true
	elsif user_filter == "s" || user_filter == "S"
		valid_filter = true
	elsif user_filter == "v" || user_filter == "V"
		valid_filter = true
	elsif user_filter == "c" || user_filter == "C"
		valid_filter = true
	elsif user_filter == "n" || user_filter == "N"
		valid_filter = true
		recipes_db.execute("SELECT * FROM recipes") do |recipe|
			puts "#{recipe["id"]}: #{recipe["name"]}"
		end
	else
		invalid_filter_input = false
		puts "Please ensure input is one of the following: t, s, v, c ,n"
	end
end
