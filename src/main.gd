extends Node

var currentLevel = 1
var points = 0
var eclapsedTime
var formattedTime

func _process(delta):
	formattedTime = time_convert(eclapsedTime)

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
