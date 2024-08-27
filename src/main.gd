extends Node

# all the global variables
var current_level = 1
var eclapsed_time
var formatted_time
var trash_list
var help_list
var current_scene = "res://src/main_menu.tscn"
var previous_scene = "res://src/main_menu.tscn"
var current_save
var trash_seen:Array # gdscript supports dynamic typing but we need to initialize this variable as an array so we can append to it
var trash_positions = [Vector2(0, 0)] # same reason as above
var trash_visible:Array # again, same as above
var camera_position
var show_hint
var hint_clicked = false
var pause_block = false

# text to speech stuff
var auto_tts = false
var tts_volume = 50
var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id = voices[0]

# scorekeeping stuff
var points = 0
var max_points = [5, 10, 20, 30, 50]
var rating = [0, 0, 0, 0, 0]

func _ready():
	# for whatever reason this needed because the variables are not set in HTML5 conditions?
	points = 0
	max_points = [5, 10, 20, 30, 50]
	rating = [0, 0, 0, 0, 0]
	
	# loads the trash database
	var trash_database = TextDatabase.new()
	var help_database = TextDatabase.new()
	trash_database.load_from_path("res://assets/trash/text.cfg")
	help_database.load_from_path("res://assets/help/helpText.cfg")
	trash_list = trash_database.get_array()
	help_list = help_database.get_array()
	# makes the trash_seen array the same size as the trash_list
	for i in trash_list.size():
		trash_seen.append(0) 
	# reads the save file to see if anything needs to be loaded
	read_save()

func _process(_delta):
	formatted_time = time_convert(eclapsed_time)
	# yet another failsafe to make sure the level property does not exceed 5 (otherwise the game will crash and that is NOT GOOD)
	if current_level > 5:
		current_level = 5

# this change scene function is here to remember what the previous scene was (so the "back" buttons can work)
func change_scene(new_scene_path):
	previous_scene = current_scene
	current_scene = new_scene_path
	get_tree().change_scene_to_file(new_scene_path)
	
func time_convert(time_in_sec):
	var seconds = int(str(eclapsed_time)) % 60
	var minutes = (int(str(time_in_sec)) / 60) % 60
	# returns a string with the format "MM:SS"
	return "%02d:%02d" % [minutes, seconds]

func write_save():
	# creates a dictionary with everything neccessary to be saved
	current_save = {
		"level": current_level,
		"rating": rating,
		"trash_seen": trash_seen
	}

	# writes the save dictionary to a file and encrypts it with a super secure password
	var save_file = FileAccess.open_encrypted_with_pass("user://wavesofwaste.save", FileAccess.WRITE, "thisisaveryverysecurepasswordthatnoonewillguess")
	if save_file != null:
		save_file.store_line(JSON.stringify(current_save))
	else:
		# nukes the save file if it's corrupted
		DirAccess.remove_absolute("user://wavesofwaste.save")
		print("nuked bc can't write")

func read_save():
	if FileAccess.file_exists("user://wavesofwaste.save"): # checks if the save file exists
		var save_game = FileAccess.open_encrypted_with_pass("user://wavesofwaste.save", FileAccess.READ, "thisisaveryverysecurepasswordthatnoonewillguess")
		# parses the save file into a dictionary
		if save_game != null:
			while save_game.get_position() < save_game.get_length():
				var json_string = save_game.get_line()
				var json = JSON.new()
				var parse_result = json.parse(json_string)
				if parse_result == OK:
					current_save = json.get_data()
				if check_save(current_save) == true:
					# actually loads the values
					current_level = current_save["level"]
					rating = current_save["rating"]
					trash_seen = current_save["trash_seen"]
				else:
					# nukes the save file if the save is not valid
					DirAccess.remove_absolute("user://wavesofwaste.save")
		else:
			# nukes the save file if it's corrupted
			DirAccess.remove_absolute("user://wavesofwaste.save")

func check_save(save_file):
	# this function validates the save file
	var level_check = false
	var rating_check = false
	var trash_seen_check = false

	# does the level property exist and is it between 1 and 5?
	if save_file.has("level") and save_file["level"] >= 1 and save_file["level"] <= 5:
		level_check = true # passes the first check

	# does the rating property exist and is it an array with 5 elements?
	if save_file.has("rating") and save_file["rating"].size() == 5:
		var is_valid = true
		# are all the elements in the rating array either 0 or 1?
		for i in save_file["rating"]:
			if save_file["rating"][i] >= 0 and save_file["rating"][i] <= 1:
				pass
			else:
				is_valid = false
				break
		if is_valid:
			rating_check = true # passes the second check
	
	# does the trash_seen property exist and is it an array with the same size as the trash_list?
	if save_file.has("trash_seen") and save_file["trash_seen"].size() == trash_list.size():
		var is_valid = true
		# are all the elements in the trash_seen array either 0 or 1?
		for i in save_file["trash_seen"]:
			if save_file["trash_seen"][i] == 0 or save_file["trash_seen"][i] == 1:
				pass
			else:
				is_valid = false
				break
		if is_valid:
			trash_seen_check = true # passes the check 

	# if all the checks pass, return true, otherwise, returns false and the save file will be nuked
	if level_check and rating_check and trash_seen_check:
		return true
	else:
		return false
