extends Area2D

func _on_body_entered(body):
	if body.name == "player": # checks if it's really the player picking up the trash; we don't want trash picking eachother up
		self.visible = false
		$CanvasLayer.show()
		get_tree().paused = true # pauses the game and show the ui

func _on_button_pressed():
	$CanvasLayer.hide()
	get_tree().paused = false # does the reverse of above
	queue_free() # kills the child
