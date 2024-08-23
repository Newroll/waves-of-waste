extends Node2D

var previous_scene

func _ready():
	for i in Main.trash_list.size():
		# duplicates the template container (templateContainer) as to how many trash there are
		%VBoxContainer.add_child(%TemplateContainer.duplicate())
	# kills the template because we don't need it anymore and it will mess things up
	%TemplateContainer.queue_free()

func _process(_delta):
	for i in Main.trash_list.size():
		# sets sprites and text as to what is in the database
		%VBoxContainer.get_child(i).get_child(0).get_child(0).get_child(0).set_texture(load("res://assets/trash/" + Main.trash_list[i].path))
		%VBoxContainer.get_child(i).get_child(0).get_child(1).get_child(0).set_text(Main.trash_list[i].name)
		%VBoxContainer.get_child(i).get_child(0).get_child(1).get_child(1).set_text(Main.trash_list[i].description)
		# only shows a silhouette of the trash if it has not been discovered yet, as well as ??? for the name
		if Main.trash_seen[i] == 0:
			%VBoxContainer.get_child(i).get_child(0).get_child(1).get_child(0).set_text("???")
			%VBoxContainer.get_child(i).get_child(0).get_child(1).get_child(1).set_text("This trash has not be discovered yet!\n\n\n")
			%VBoxContainer.get_child(i).get_child(0).get_child(0).get_child(0).modulate = Color(0, 0, 0, 1)

func _input(event): # hotkey shortcut stuff
	if event.is_action_pressed("escape"):
		_on_back_button_pressed()

func _on_back_button_pressed():
	Main.pause_block = false
	get_tree().paused = false
	$BackSFX.play()
	await get_tree().create_timer(0.23).timeout
	if Main.current_scene.left( - 7) == "res://src/levels/level":
		Main.pause_block = true
		get_tree().paused = true
		queue_free()
	else:
		Main.change_scene(Main.previous_scene)
