require 'sqlite3'

recipes_db = SQLite3::Database.new("recipes.db")
recipes_db.results_as_hash = true

create_recipe_table_cmd = <<-SQL
  CREATE TABLE IF NOT EXISTS recipes(
    id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    source VARCHAR(255),
    type VARCHAR(255),
    season VARCHAR(255),
    cook_time_hr REAL,
    preprep VARCHAR(255),
    tips VARCHAR(255),
    diet_vegan BOOLEAN,
    diet_vegetarian BOOLEAN,
    diet_paleo BOOLEAN,
    diet_gluten_free BOOLEAN,
    diet_grain_free BOOLEAN
  )
SQL

recipes_db.execute(create_recipe_table_cmd)

# chickpea_curry = {
# 	"name" => "Slow-Cooker Vegetable Chickpea Curry",
# 	"source" => "MyRecipes",
# 	"type" => "Entree",
#     "cook_time_hr" => 6.5,
#     "preprep" => ,
#     tips VARCHAR(255),
#     diet_vegan BOOLEAN,
#     diet_vegetarian BOOLEAN,
#     diet_paleo BOOLEAN,
#     diet_gluten_free BOOLEAN,
#     diet_grain_free BOOLEAN
# }