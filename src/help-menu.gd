extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# sets the text + animation
	for i in 5:
		get_node("leftStackText/helpText" + str(i)).set_text(Main.helpList[i].name)
	%title.set_text(Main.helpList[0].title)
	%description.set_text(Main.helpList[0].text)

func _input(event):
	if event.is_action_pressed("escape"):
		_on_back_button_pressed()

func _on_back_button_pressed():
	get_tree().paused = false
	$backsfx.play()
	await get_tree().create_timer(0.23).timeout
	if Main.currentScene.left(-7) == "res://src/levels/level":
		get_tree().paused = true
		queue_free()
	else:
		Main.change_scene(Main.previousScene)

func _on_help_button_0_pressed():
	%title.set_text(Main.helpList[0].title)
	%description.set_text(Main.helpList[0].text)
	%AnimatedSprite2D.set_animation("movement")

func _on_help_button_1_pressed():
	%title.set_text(Main.helpList[1].title)
	%description.set_text(Main.helpList[1].text)
	%AnimatedSprite2D.set_animation("pickup")

func _on_help_button_2_pressed():
	%title.set_text(Main.helpList[2].title)
	%description.set_text(Main.helpList[2].text)
	%AnimatedSprite2D.set_animation("lvlComplete")

func _on_help_button_3_pressed():
	%title.set_text(Main.helpList[3].title)
	%description.set_text(Main.helpList[3].text)
	%AnimatedSprite2D.set_animation("lvlSwitch")

func _on_help_button_4_pressed():
	%title.set_text(Main.helpList[4].title)
	%description.set_text(Main.helpList[4].text)
	%AnimatedSprite2D.set_animation("lvlComplete")
