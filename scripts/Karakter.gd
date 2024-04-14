extends RigidBody2D
class_name Player

@export var speed = 600
@export var dash_force = 1000
@onready var dash_cooldown = $DashCooldown
@onready var sprite = $Sprite
@onready var anim_player = $AnimationPlayer

func _physics_process(delta):
	var input_vector = Input.get_vector("move_left","move_right","move_up","move_down")
	#if input_vector.length() > 0 and freeze:
		#freeze = false
	if input_vector.length() > 0 and !anim_player.is_playing():
		anim_player.play("walk")
	apply_central_force(input_vector.normalized()*speed)
	if sign(input_vector.x) > 0:
		sprite.flip_h = true
	elif sign(input_vector.x) < 0:
		sprite.flip_h = false
	
	if Input.is_action_just_pressed("dash") and dash_cooldown.time_left <= 0:
		apply_central_impulse(input_vector.normalized()*dash_force)
		dash_cooldown.start()
		anim_player.play("dash")

func teleport_to_given_pos(new_pos):
	PhysicsServer2D.body_set_state(
	get_rid(),
	PhysicsServer2D.BODY_STATE_TRANSFORM,
	Transform2D.IDENTITY.translated(new_pos)
)
