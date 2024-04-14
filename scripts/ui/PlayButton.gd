extends Button

signal game_started

func _ready():
	pressed.connect(on_pressed)

func on_pressed():
	game_started.emit()
	await get_tree().create_timer(1).timeout
	var tutorial_scene = load("res://scenes/intro_dialogue_screen.tscn")
	get_tree().change_scene_to_packed(tutorial_scene)
	
