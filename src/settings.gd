extends Node2D

func _ready():
	# sets settings to reflect actual current status
	$VBoxContainer/MasterVolume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$VBoxContainer/MusicVolume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	$VBoxContainer/SFXVolume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	if Main.auto_tts == true:
		$VBoxContainer/TTSContainer/TTSCheck.button_pressed = true

func _on_master_volume_value_changed(value): # sets the volume of the master bus
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _on_music_volume_value_changed(value): # sets the volume of the music bus
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))

func _on_sfx_volume_value_changed(value): # sets the volume of the sfx bus
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))

func _on_tts_check_toggled(toggled_on): # tts toggle thing
	Main.auto_tts = toggled_on

func _on_back_button_pressed():
	Main.pause_block = false
	get_tree().paused = false
	$BackSFX.play()
	await get_tree().create_timer(0.23).timeout
	if Main.current_scene == "res://src/levels.tscn":
		get_tree().paused = true
		queue_free()
	else:
		Main.change_scene(Main.previous_scene)
