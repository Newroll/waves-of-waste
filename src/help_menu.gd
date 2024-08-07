extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# sets the default text + animation
	for i in 5:
		get_node("LeftBG/LeftStack/HelpButton" + str(i)).set_text(Main.help_list[i].name)
	%Title.set_text(Main.help_list[0].title)
	%Description.set_text(Main.help_list[0].text)

func _input(event): # hotkey shortcut stuff
	if event.is_action_pressed("escape"):
		_on_back_button_pressed()

func _on_back_button_pressed():
	get_tree().paused = false
	$BackSFX.play()
	await get_tree().create_timer(0.23).timeout
	if Main.current_scene == "res://src/levels.tscn":
		get_tree().paused = true
		queue_free()
	else:
		Main.change_scene(Main.previous_scene)

func _on_help_button_0_pressed():
	%Title.set_text(Main.help_list[0].title)
	%Description.set_text(Main.help_list[0].text)
	%Animation.set_animation("movement") # sets the right side of the screen to show the relevent help stuff

# same thing
func _on_help_button_1_pressed():
	%Title.set_text(Main.help_list[1].title)
	%Description.set_text(Main.help_list[1].text)
	%Animation.set_animation("pickup")

func _on_help_button_2_pressed():
	%Title.set_text(Main.help_list[2].title)
	%Description.set_text(Main.help_list[2].text)
	%Animation.set_animation("lvlComplete")

func _on_help_button_3_pressed():
	%Title.set_text(Main.help_list[3].title)
	%Description.set_text(Main.help_list[3].text)
	%Animation.set_animation("lvlSwitch")

func _on_help_button_4_pressed():
	%Title.set_text(Main.help_list[4].title)
	%Description.set_text(Main.help_list[4].text)
	%Animation.set_animation("lvlComplete")
