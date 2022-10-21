extends Control

var sql = SQLReadWrite.new()

var table = "Users"
var table2 = "Users_Sessions"
var result

func _ready():
	
	result = sql.select(table)
	print(result)
	result = sql.select(table, "WHERE", "ID=3")
	print(result)
	result = sql.left_join(table, table2)
	print(result)
	result = sql.update_row(table, "Name", '"New Name"')
	print(result)
	result = sql.update_row(table, "Name", '"New Name"', "WHERE", "ID=1")
	print(result)




#func _on_Button_pressed():
#	var nameUser = nameText.get_text()
#	var score = scoreText.get_text()
#	if  nameUser == "" or score == "":
#		label.set_text("Nothing Inputted!")
#	else:
#		dict["Name"] = nameUser
#		dict["Score"] = score
#		sql.commitDataToDB(table, dict)
#		result_dict = sql.readFromDB(query, dict)
#		label.set_text(str(result_dict))
		
		


