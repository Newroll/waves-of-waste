extends Node2D

func _ready():
	# sets the text of the buttons to the names of the help titles with a for loop
	for i in 4:
		get_node("LeftBG/LeftStack/HelpButton" + str(i)).set_text(Main.help_list[i].name)
	%Title.set_text(Main.help_list[0].title) # sets the default state
	%Description.set_text(Main.help_list[0].text)

func _input(event): # hotkey shortcuts
	if event.is_action_pressed("escape"):
		_on_back_button_pressed()

func _on_back_button_pressed():
	get_tree().paused = false
	$BackSFX.play()
	await get_tree().create_timer(0.23).timeout # wait for the sound effect to finish playing before switching scenes
	# if the current scene is the levels scene, kills itself. otherwise goes back to the previous scene
	if Main.current_scene == "res://src/levels.tscn":
		Main.pause_block = false
		get_tree().paused = true
		queue_free()
	else:
		Main.change_scene(Main.previous_scene)

func _on_help_button_0_pressed():
	# sets the right side of the screen to show the relevent help topic
	$ForwardSFX.play()
	%Title.set_text(Main.help_list[0].title)
	%Description.set_text(Main.help_list[0].text)
	%Animation.set_animation("movement")

# same thing
func _on_help_button_1_pressed():
	$ForwardSFX.play()
	%Title.set_text(Main.help_list[1].title)
	%Description.set_text(Main.help_list[1].text)
	%Animation.set_animation("pickup")

func _on_help_button_2_pressed():
	$ForwardSFX.play()
	%Title.set_text(Main.help_list[2].title)
	%Description.set_text(Main.help_list[2].text)
	%Animation.set_animation("lvlComplete")

func _on_help_button_3_pressed():
	$ForwardSFX.play()
	%Title.set_text(Main.help_list[3].title)
	%Description.set_text(Main.help_list[3].text)
	%Animation.set_animation("lvlSwitch")
