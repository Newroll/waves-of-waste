extends Node2D

func _ready():
	$VBoxContainer/MasterVolume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$VBoxContainer/MusicVolume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("music")))
	$VBoxContainer/SFXVolume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("sfx")))
	$VBoxContainer/TTSVolume.value = Main.tts_volume
	if Main.auto_tts == true:
		$VBoxContainer/TTSContainer/TTSCheck.button_pressed = true

func _on_master_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _on_music_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))

func _on_sfx_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))

func _on_tts_volume_value_changed(value):
	Main.tts_volume = value

func _on_back_button_pressed():
	get_tree().paused = false
	$BackSFX.play()
	await get_tree().create_timer(0.23).timeout
	if Main.current_scene == "res://src/levels.tscn":
		get_tree().paused = true
		queue_free()
	else:
		Main.change_scene(Main.previous_scene)

func _on_tts_check_toggled(toggled_on):
	Main.auto_tts = toggled_on
