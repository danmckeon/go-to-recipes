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

def get_recipes_by_source(recipes_db, recipe_source_input)
	filtered_recipes_arr = []

	if recipe_source_input == "a" || recipe_source_input == "A"
		recipe_source_str = "AllRecipes"
	elsif recipe_source_input == "f" || recipe_source_input == "F"
		recipe_source_str = "Food Network"
	elsif recipe_source_input == "52"
		recipe_source_str = "Food52"
	elsif recipe_source_input == "m" || recipe_source_input == "M"
		recipe_source_str = "MyRecipes"
	elsif recipe_source_input == "s" || recipe_source_input == "S"
		recipe_source_str = "Smitten Kitchen"
	else
		recipe_source_str = ""
		puts "Please ensure your recipe type input is one of the following: a, f, 52, m, s"
	end

	recipes_db.execute("SELECT * FROM recipes WHERE source=?", recipe_source_str) do |recipe|
		filtered_recipes_arr << recipe["id"]
	end
	filtered_recipes_arr
end

def get_vegan_recipes(recipes_db)
	filtered_recipes_arr = []
	recipes_db.execute("SELECT * FROM recipes WHERE diet_vegan='true'") do |recipe|
		filtered_recipes_arr << recipe["id"]
	end
	filtered_recipes_arr
end

def get_recipes_by_cook_time(recipes_db, cook_time)
	filtered_recipes_arr = []
	recipes_db.execute("SELECT * FROM recipes WHERE cook_time_hr <= ?", cook_time) do |recipe|
		filtered_recipes_arr << recipe["id"]
	end

	if filtered_recipes_arr.empty? 
		puts "Please ensure cook time input is numerical and greater than or equal to 0.75"
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

def get_ingredients_for_recipe(recipes_db, recipe_choice_input)
	ingredients_hash = recipes_db.execute("SELECT * FROM ingredients WHERE recipe_id = ?", recipe_choice_input)
end

recipes_db = SQLite3::Database.new("recipes.db")
recipes_db.results_as_hash = true

filtered_recipes_arr = []

puts "Please choose a metric to filter recipes by: " 
puts "t: type (entree, dessert, etc.)\ns: source (website/blog)\nv: vegan recipes only\nc: cook time (you will enter max cook time next)\nn: no filter"

user_filter = gets.chomp

if user_filter == "t" || user_filter == "T"
	puts "Please enter a recipe type: \nb: breakfast \ns: salad \np: soup \ne: entree \nd: dessert"
	recipe_type_input = gets.chomp
	filtered_recipes_arr = get_recipes_by_type(recipes_db, recipe_type_input)
elsif user_filter == "s" || user_filter == "S"
	puts "Please enter preferred source: \na: allrecipes \nf:food network \n52: food52 \nm: myrecipes \ns: smitten kitchen"
	recipe_source_input = gets.chomp
	filtered_recipes_arr = get_recipes_by_source(recipes_db, recipe_source_input)
elsif user_filter == "v" || user_filter == "V"
	filtered_recipes_arr = get_vegan_recipes(recipes_db)
elsif user_filter == "c" || user_filter == "C"
	puts "Please enter maximum cook time in hours (input must be 0.75 or greater): "
	cook_time = gets.chomp.to_i
	filtered_recipes_arr = get_recipes_by_cook_time(recipes_db, cook_time)
elsif user_filter == "n" || user_filter == "N"
	filtered_recipes_arr = get_all_recipes(recipes_db)
else
	puts "Please ensure input is one of the following: t, s, v, c ,n"
end

if filtered_recipes_arr.empty?
	puts "Please try another query, ensuring input is valid"
else
	if filtered_recipes_arr.length > 1
		puts "Please select a recipe from the list below with numerical input for which you would like to generate the ingredient list: "
		filtered_recipes_arr.each do |recipe_id|
			recipes_db.execute("SELECT * FROM recipes WHERE id = ?", recipe_id) do |recipe|
				puts "#{recipe["id"]}: #{recipe["name"]}"
			end
		end
		recipe_choice_input = gets.chomp
	else
		puts "There is only one recipe that satisfies your filters"
		recipe_choice_input = filtered_recipes_arr.first
	end
	recipe_choice_hash = recipes_db.execute("SELECT * FROM recipes WHERE id = ?", recipe_choice_input)
	recipe_choice_str = recipe_choice_hash[0]["name"]
	puts "Ingredient List for #{recipe_choice_str}: "
	ingredients_hash = get_ingredients_for_recipe(recipes_db, recipe_choice_input)
	
end

# ingredients_hash1 = get_ingredients_for_recipe(recipes_db, 1)
# ingredients_hash3 = get_ingredients_for_recipe(recipes_db, 3)

# total_ingredients = ingredients_hash1[0].merge(ingredients_hash3[0]) {|ingredient, qty1, qty2| qty1 + qty2}


# puts "Chickpea Curry Ingredients: "
# ingredients_hash1[0].each do |key, value|
# 		puts "#{key}: #{value}"
# end

# puts "Tomato and Sausage Risotto Ingredients: "
# ingredients_hash3[0].each do |key, value|
# 		puts "#{key}: #{value}"
# end

# puts "Combined Ingredients: "
# total_ingredients.each do |key, value|
# 		puts "#{key}: #{value}"
# end