extends Node2D

# SQLReadWrite selects and executes data into an SQLite Database
# It provides the following functions:
# commitDataToDB(table, dict)
# readFromDB(query, dict)
# generateDictionary(table)
# select(table, clause(optional), cond(optional))
# left_join(table1, table2)
# update_row(table, item, newItem, clause(optional), cond(optional))

class_name SQLReadWrite

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db #database object
var db_name = "res://Databases/DnDatabase" #path to DB

func _init():
	# Initialize database object and name
	db = SQLite.new()
	db.path = db_name
	
	
# commitDataToDB: Takes 2 values, a table name and a dictionary with data and 
# inserts into the database 
func commitDataToDB(table, dict):
	db.open_db()
	db.insert_row(table, dict)
	db.close_db()

# readFromDB: Takes 2 values, a SQL query (string) and a dictionary. 
# This executes the query based off the dictionary's values.
func readFromDB(query, dict):
	db.open_db()
	db.query(query)
	var column_name
	var call_result
	var result_array = []

	# for loop that loops through table base on the size of the called 
	for i in range(0, db.query_result.size()): # "i" is the id of the row
		# for loop selects the column name (with "key")
		for key in dict.keys():
			column_name = key
			call_result = str(db.query_result[i][column_name])
			dict[column_name] = call_result
		# At this point, store the data
			result_array.append(call_result)
	return result_array
	db.close_db()

# generateDictionary: Creates a dictionary so that the table can run a proper query
func generateDictionary(table):
	db.open_db()
	var dict = Dictionary()
	var query = "PRAGMA table_info("+table+");"
	db.query(query)
	var result
	for i in range(0, db.query_result.size()):
		result = str(db.query_result[i]["name"])
	return dict
	db.close_db()

# Creates an sql statement to select from a table. 
# You can put in a clause and condition if you need a specific dataset.
func select(table, clause=null, cond=null):
	var query = "SELECT * FROM " + table
	
	match clause:
		"WHERE":
			query += " " + clause + " " + cond
	query += ";"
	return query

func left_join(table, table2):
	var query = "SELECT * FROM " + table + " ON " + table2 + " WHERE " + table + ".ID = ID;"
	return query
	
func update_row(table, item, newItem, clause=null, cond=null):
	var query = "UPDATE " + table + " SET " + item + " = " + newItem
	match clause:
		"WHERE":
			query += " " + clause + " " + cond
	query += ";"
	return query
