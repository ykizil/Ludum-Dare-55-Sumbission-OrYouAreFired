extends Area2D

@export var next_level_path : PackedScene
signal next_scene_load

func _ready():
	body_entered.connect(on_body_entered)

func on_body_entered(body):
	if body is Player:
		next_scene_load.emit()
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_packed(next_level_path)
