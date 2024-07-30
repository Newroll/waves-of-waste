extends Node

var current_level = 1
var points = 0
var eclapsed_time
var formatted_time
var trash_list
var help_list
var current_scene = "res://src/main_menu.tscn"
var previous_scene
var current_save
var trash_seen:Array # gdscript supports dynamic typing but we need to initialize this variable as an array so we can append to it

# text to speech stuff
var auto_tts = false
var tts_volume = 50
var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id = voices[0]

# scorekeeping stuff
var max_points = [5, 10, 20, 30, 50]
var rating = [0, 0, 0, 0, 0]

func _ready():
	# loads the trash database
	var trash_database = TextDatabase.new()
	var help_database = TextDatabase.new()
	trash_database.load_from_path("res://assets/trash/text.cfg")
	help_database.load_from_path("res://assets/help/helpText.cfg")
	trash_list = trash_database.get_array()
	help_list = help_database.get_array()
	# trash saving stuff
	for i in trash_list.size():
		trash_seen.append(0) 
	# finally reads the save
	read_save()

func _process(_delta):
	formatted_time = time_convert(eclapsed_time)
	if current_level > 5:
		current_level = 5

func change_scene(newScenePath):
	previous_scene = current_scene
	current_scene = newScenePath
	get_tree().change_scene_to_file(newScenePath)
	
func time_convert(time_in_sec):
	# i have no idea why i have to convert it to a string first
	# eclapsed time is of type 3 -- which is a floating point integer
	# technically int() should be able to convert it to a whole integer
	# however it throws "nonexistent int constructor"
	# but doing this works so i'm not complaining
	var seconds = int(str(eclapsed_time)) % 60
	var minutes = (int(str(time_in_sec)) / 60) % 60
	#returns a string with the format "MM:SS"
	return "%02d:%02d" % [minutes, seconds]

func write_save():
	current_save = {
		"level": current_level,
		"rating": rating,
		"trash_seen": trash_seen
	}
	# writes the save array to a file
	FileAccess.open("user://wavesofwaste.save", FileAccess.WRITE).store_line(JSON.stringify(current_save))

func read_save():
	if FileAccess.file_exists("user://wavesofwaste.save"): # checks if the save file exists
		var save_game = FileAccess.open("user://wavesofwaste.save", FileAccess.READ)
		# json parsing stuff
		while save_game.get_position() < save_game.get_length():
			var json_string = save_game.get_line()
			var json = JSON.new()
			var parse_result = json.parse(json_string)
			if parse_result == OK:
				current_save = json.get_data()
			else:
				print("Error parsing save file")
			current_level = current_save["level"] # actually loads the value
			rating = current_save["rating"]
			trash_seen = current_save["trash_seen"]
