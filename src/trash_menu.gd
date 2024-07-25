extends Node2D

var previous_scene

func _ready():
	# time to mess with arrays (yay)
	for i in Main.trash_list.size():
		# duplicates the template container (templateContainer) as to how many trash there are
		%VBoxContainer.add_child(%TemplateContainer.duplicate())
		# kills the template bc we don't need it anymore and it will mess things up
		%TemplateContainer.queue_free()
		# sets sprites and text as to what is in the database
		%VBoxContainer.get_child(i).get_child(0).get_child(0).get_child(0).set_texture(load("res://assets/trash/" + Main.trash_list[i].path))
		%VBoxContainer.get_child(i).get_child(0).get_child(1).get_child(0).set_text(Main.trash_list[i].name)
		%VBoxContainer.get_child(i).get_child(0).get_child(1).get_child(1).set_text(Main.trash_list[i].description)

func _input(event):
	if event.is_action_pressed("escape"):
		_on_back_button_pressed()

func _on_back_button_pressed():
	get_tree().paused = false
	$BackSFX.play()
	await get_tree().create_timer(0.23).timeout
	if Main.current_scene.left( - 7) == "res://src/levels/level":
		get_tree().paused = true
		queue_free()
	else:
		Main.change_scene(Main.previous_scene)
