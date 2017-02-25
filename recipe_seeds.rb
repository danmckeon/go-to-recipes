require 'sqlite3'

def load_recipes_db(recipes_db, recipes)
	recipes.each do |recipe|
		recipes_db.execute("INSERT INTO recipes (name, source, type, cook_time_hr, diet_vegan) 
			VALUES (?, ?, ?, ?, ?)", recipe)
	end
end

recipes_db = SQLite3::Database.new("recipes.db")
recipes_db.results_as_hash = true

create_recipe_table_cmd = <<-SQL
  CREATE TABLE IF NOT EXISTS recipes(
    id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    source VARCHAR(255),
    type VARCHAR(255),
    cook_time_hr REAL,
    diet_vegan BOOLEAN
  )
SQL

recipes_db.execute(create_recipe_table_cmd)

recipes = [

	[
		"Slow-Cooker Vegetable Chickpea Curry",
		"MyRecipes",
		"Entree",
	    "6.5",
	    "true"
	],

	[
		"No-Cream Pasta Primavera",
		"AllRecipes",
		"Entree",
	    "1",
	    "false"
	],

	[
		"Tomato and Sausage Risotto",
		"Smitten Kitchen",
		"Entree",
	    "1",
	    "false"
	],

	[
		"Lentil Quinoa Salad",
		"Food Network",
		"Salad",
	    "0.75",
	    "true"
	],

	[
		"Slow-Cooker Sweet Potato and Lentil Soup",
		"Food Network",
		"Soup",
	    "8.5",
	    "true"
	],

	[
		"Almost Flourless Chocolate Cake",
		"Food52",
		"Dessert",
	    "1",
	    "false"
	],

	[
		"Slow-Baked Broccoli Frittata",
		"Food52",
		"Breakfast",
	    "1",
	    "false"
	]

]

load_recipes_db(recipes_db, recipes)