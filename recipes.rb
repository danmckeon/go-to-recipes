# Pseudocode
# 1) Ask user for filter
# 2) Show recipes
# 3) User selects recipes
# 4) Show ingredients
# * Additional features: Multiple recipes selection, add a recipe, edit a recipe

require 'sqlite3'

def get_recipes_by_type(recipes_db, recipe_type_input)
	filtered_recipes_arr = []

	if recipe_type_input == "b" || recipe_type_input == "B"
		recipe_type_str = "Breakfast"
	elsif recipe_type_input == "s" || recipe_type_input == "S"
		recipe_type_str = "Salad"
	elsif recipe_type_input == "p" || recipe_type_input == "P"
		recipe_type_str = "Soup"
	elsif recipe_type_input == "e" || recipe_type_input == "E"
		recipe_type_str = "Entree"
	elsif recipe_type_input == "d" || recipe_type_input == "D"
		recipe_type_str = "Dessert"
	else
		recipe_type_str = ""
		puts "Please ensure your recipe type input is one of the following: b, s, p, e ,d"
	end

	recipes_db.execute("SELECT * FROM recipes WHERE type=?", recipe_type_str) do |recipe|
		filtered_recipes_arr << recipe["id"]
	end
	filtered_recipes_arr
end

def get_all_recipes(recipes_db)
	filtered_recipes_arr = []
	recipes_db.execute("SELECT * FROM recipes") do |recipe|
		filtered_recipes_arr << recipe["id"]
	end
	filtered_recipes_arr
end

recipes_db = SQLite3::Database.new("recipes.db")
recipes_db.results_as_hash = true

valid_filter = false

filtered_recipes_arr = []

puts "Please choose a metric to filter recipes by: " 
puts "t: type (entree, dessert, etc.)\ns: source (website/blog)\nv: vegan meals only\nc: cook time (you will enter max cook time next)\nn: no filter"

user_filter = gets.chomp

if user_filter == "t" || user_filter == "T"
	puts "Please enter a recipe type: \nb: breakfast \ns: salad \np: soup \ne: entree \nd: dessert"
	recipe_type_input = gets.chomp
	filtered_recipes_arr = get_recipes_by_type(recipes_db, recipe_type_input)
elsif user_filter == "s" || user_filter == "S"
	puts "Please enter preferred source: \na: allrecipes \nf:food network \n52: food52 \nm: myrecipes \ns: smitten kitchen"
	recipe_source_input = gets.chomp
	filtered_recipes_arr = get_recipes_by_type(recipes_db, recipe_type_input)
elsif user_filter == "v" || user_filter == "V"

elsif user_filter == "c" || user_filter == "C"

elsif user_filter == "n" || user_filter == "N"
	filtered_recipes_arr = get_all_recipes(recipes_db)
else
	puts "Please ensure input is one of the following: t, s, v, c ,n"
end

puts filtered_recipes_arr

# puts "Enter the recipe number below for which you would like to generate an ingredient list: "



# while valid_recipe_choice == false