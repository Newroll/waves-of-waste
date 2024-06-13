extends Area2D

var trash
var rotationVar

func _ready():
	trash = int(randf_range(1, 9)) # randomizes the trash sprite
	# automagically sets everything
	if trash == 1:
		$trashSprite.texture = load("res://assets/trash/candy_wrapper.png")
		$CanvasLayer/TextureRect.texture = load("res://assets/trash/candy_wrapper.png")
		$CanvasLayer/description.text = Main.trashList[0].description
	elif trash == 2:
		$trashSprite.texture = load("res://assets/trash/chip_bag.png")
		$CanvasLayer/TextureRect.texture = load("res://assets/trash/chip_bag.png")
		$CanvasLayer/description.text = Main.trashList[1].description
	elif trash == 3:
		$trashSprite.texture = load("res://assets/trash/glass_bottle.png")
		$CanvasLayer/TextureRect.texture = load("res://assets/trash/glass_bottle.png")
		$CanvasLayer/description.text = Main.trashList[2].description
	elif trash == 4:
		$trashSprite.texture = load("res://assets/trash/plastic_bag.png")
		$CanvasLayer/TextureRect.texture = load("res://assets/trash/plastic_bag.png")
		$CanvasLayer/description.text = Main.trashList[3].description
	elif trash == 5:
		$trashSprite.texture = load("res://assets/trash/plastic_wrap.png")
		$CanvasLayer/TextureRect.texture = load("res://assets/trash/plastic_wrap.png")
		$CanvasLayer/description.text = Main.trashList[4].description
	elif trash == 6:
		$trashSprite.texture = load("res://assets/trash/plastic_bag.png")
		$CanvasLayer/TextureRect.texture = load("res://assets/trash/plastic_bag.png")
		$CanvasLayer/description.text = Main.trashList[5].description
	elif trash == 7:
		$trashSprite.texture = load("res://assets/trash/plastic_bottle.png")
		$CanvasLayer/TextureRect.texture = load("res://assets/trash/plastic_bottle.png")
		$CanvasLayer/description.text = Main.trashList[6].description
	elif trash == 8:
		$trashSprite.texture = load("res://assets/trash/smoothie_bottle.png")
		$CanvasLayer/TextureRect.texture = load("res://assets/trash/smoothie_bottle.png")
		$CanvasLayer/description.text = Main.trashList[7].description
	rotationVar = randf_range(0, 360)
	$trashSprite.rotate(rotationVar) # randomizes the rotation of the trash

func _process(_delta):
	# very very ghetto animation (why does this not work)
	while true:
		$trashSprite.rotate(rotationVar + 30)
		await get_tree().create_timer(1.0).timeout
		$trashSprite.rotate(rotationVar - 30)
		await get_tree().create_timer(1.0).timeout
		$trashSprite.rotate(rotationVar + 30)
		await get_tree().create_timer(1.0).timeout
		$trashSprite.rotate(rotationVar - 30)

func _on_body_entered(body):
	if body.name == "player": # checks if it's really the player picking up the trash; we don't want trash picking each other up
		self.visible = false
		Main.points += 1
		$CanvasLayer.show()
		get_tree().paused = true # pauses the game and show the ui

func _on_return_button_pressed():
	$CanvasLayer.hide()
	get_tree().paused = false # does the reverse of above
	queue_free() # kills the child