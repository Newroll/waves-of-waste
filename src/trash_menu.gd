extends Node2D

var previousScene

func _ready():
	# time to mess with arrays (yay)
	for i in Main.trashList.size():
		# duplicates the template container (templateContainer) as to how many trash there are
		%VBoxContainer.add_child(%templateContainer.duplicate())
		# kills the template bc we don't need it anymore and it will mess things up
		%templateContainer.queue_free()
		# sets sprites and text as to what is in the database
		%VBoxContainer.get_child(i).get_child(0).get_child(0).get_child(0).set_texture(load("res://assets/trash/" + Main.trashList[i].path))
		%VBoxContainer.get_child(i).get_child(0).get_child(1).get_child(0).set_text(Main.trashList[i].name)
		%VBoxContainer.get_child(i).get_child(0).get_child(1).get_child(1).set_text(Main.trashList[i].description)

func _on_back_button_pressed():
	get_tree().paused = false
	$backsfx.play()
	await get_tree().create_timer(0.23).timeout
	if Main.currentScene.left(-7) == "res://src/levels/level":
		get_tree().paused = true
		queue_free()
	else:
		Main.change_scene(Main.previousScene)
