require 'sqlite3'

recipes_db = SQLite3::Database.new("recipes.db")
recipes_db.results_as_hash = true

