extends Node

var currentLevel = 1
var points = 0
var eclapsedTime
var formattedTime
var trashList
var currentScene = "res://src/main-menu.tscn"
var previousScene

func _ready():
	var trashDatabase = TextDatabase.new()
	trashDatabase.load_from_path("res://assets/trash/text.cfg")
	trashList = trashDatabase.get_array()

func _process(delta):
	formattedTime = time_convert(eclapsedTime)

func change_scene(newScenePath):
	previousScene = currentScene
	currentScene = newScenePath
	get_tree().change_scene_to_file(currentScene)

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
