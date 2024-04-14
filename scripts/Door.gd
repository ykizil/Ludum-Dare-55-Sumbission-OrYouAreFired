extends StaticBody2D

@export var active = true
@onready var collision_shape = $CollisionShape
@onready var sprite = $Sprite
@onready var sprite_deactive = $SpriteDeactive
@onready var particles = $Particles

func _ready():
	if !active:
		deactivate_door()
	$%EventBus.penta_activated.connect(toogle_door)

func toogle_door():
	if active:
		deactivate_door()
		return
	activate_door()

func activate_door():
	active = true
	sprite.visible = true
	sprite_deactive.visible = false
	collision_shape.set_deferred("disabled",false)
	particles.emitting = true

func deactivate_door():
	active = false
	sprite.visible = false
	sprite_deactive.visible = true
	collision_shape.set_deferred("disabled",true)
	particles.emitting = false

