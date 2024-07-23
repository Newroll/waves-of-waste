extends Node

var currentLevel = 1
var points = 0
var eclapsedTime
var formattedTime
var trashList
var helpList
var currentScene = "res://src/main-menu.tscn"
var previousScene
var currentSave

# scorekeeping stuff
var maxPoints =  [5, 10, 20, 30, 50]
var rating = [0, 0, 0, 0, 0]

func _ready():
	# loads the trash database
	var trashDatabase = TextDatabase.new()
	var helpDatabase = TextDatabase.new()
	trashDatabase.load_from_path("res://assets/trash/text.cfg")
	helpDatabase.load_from_path("res://assets/help/helpText.cfg")
	trashList = trashDatabase.get_array()
	helpList = helpDatabase.get_array()
	readSave()

func _process(_delta):
	formattedTime = time_convert(eclapsedTime)
	if currentLevel > 5:
		currentLevel = 5

func change_scene(newScenePath):
	previousScene = currentScene
	currentScene = newScenePath
	get_tree().change_scene_to_file(newScenePath)
	
func time_convert(time_in_sec):
	# i have no idea why i have to convert it to a string first
	# eclapsed time is of type 3 -- which is a floating point integer
	# technically int() should be able to convert it to a whole integer
	# however it throws "nonexistent int constructor"
	# but doing this works so i'm not complaining
	var seconds = int(str(eclapsedTime))%60
	var minutes = (int(str(time_in_sec))/60)%60
	#returns a string with the format "MM:SS"
	return "%02d:%02d" % [minutes, seconds]

func writeSave():
	currentSave = {
		"level" : currentLevel,
		"rating" : rating
	}
	# writes the save array to a file
	FileAccess.open("user://savegame.save", FileAccess.WRITE).store_line(JSON.stringify(currentSave))

func readSave():
	if FileAccess.file_exists("user://savegame.save"): # checks if the save file exists
		var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
		# json parsing stuff
		while save_game.get_position() < save_game.get_length():
			var json_string = save_game.get_line()
			var json = JSON.new()
			var parse_result = json.parse(json_string)
			if parse_result == OK:
				currentSave = json.get_data()
			else: 
				print("Error parsing save file")
			currentLevel = currentSave["level"] # actually loads the value
