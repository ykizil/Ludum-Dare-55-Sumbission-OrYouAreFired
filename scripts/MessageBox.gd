extends Area2D

var active = false

func _ready():
	modulate.a = 0
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)

func on_body_entered(body):
	if body is Player:
		active = true

func on_body_exited(body):
	if body is Player:
		active = false

func _process(delta):
	if active:
		modulate.a = lerp(modulate.a,1.0,0.2)
	else:
		modulate.a = lerp(modulate.a,0.0,0.2)
