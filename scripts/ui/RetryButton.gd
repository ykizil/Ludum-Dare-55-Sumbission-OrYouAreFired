extends Button

signal scene_ended

func _ready():
	pressed.connect(on_pressed)

func on_pressed():
	scene_ended.emit()
	await get_tree().create_timer(1).timeout
	var tutorial_scene = load("res://scenes/main.tscn")
	get_tree().change_scene_to_packed(tutorial_scene)
	
