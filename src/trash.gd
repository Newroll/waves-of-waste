extends Area2D

func _on_body_entered(body):
	if body.name == "player":
		self.visible = false
		$CanvasLayer.show()
		get_tree().paused = true

func _on_button_pressed():
	$CanvasLayer.hide()
	get_tree().paused = false
	queue_free()
