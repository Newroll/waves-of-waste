extends Node2D

func _ready():
	$VBoxContainer/masterVolume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$VBoxContainer/musicVolume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("music")))
	$VBoxContainer/sfxVolume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("sfx")))

func _on_master_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _on_music_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), linear_to_db(value))

func _on_sfx_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), linear_to_db(value))

func _on_back_button_pressed():
	get_tree().paused = false
	$backsfx.play()
	await get_tree().create_timer(0.23).timeout
	if Main.currentScene.left(-7) == "res://src/levels/level":
		get_tree().paused = true
		queue_free()
	else:
		Main.change_scene(Main.previousScene)
