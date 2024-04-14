extends Area2D

var overlapping_bodies = []

func _ready():
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)

func on_body_entered(body):
	overlapping_bodies.append(body)

func on_body_exited(body):
	if body in overlapping_bodies:
		overlapping_bodies.erase(body)

func is_overlapping_body():
	return overlapping_bodies.size() > 0
