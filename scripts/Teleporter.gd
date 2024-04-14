extends Node2D

@export var disabled = true
@export var player : Node2D
@onready var cooldown_timer = $CooldownTimer
@onready var teleport_collision_check = $TeleportCollisionCheck
@onready var teleport_area_indicator = $TeleportAreaIndicator
@onready var time_left_label = $TeleportAreaIndicator/TimeLeft
@onready var tele_sfx = $TeleSFX

func _ready():
	cooldown_timer.timeout.connect(enable)
	disable()

func _physics_process(delta):
	global_position = get_global_mouse_position()
	global_position.x = clamp(global_position.x, player.global_position.x-200, player.global_position.x+200)
	global_position.y = clamp(global_position.y, player.global_position.y-200, player.global_position.y+200)
	teleport_area_indicator.modulate.a = clamp(get_distance_to_player()/200-0.2,0,0.6)
	teleport_area_indicator.global_position = player.global_position
	if Input.is_action_just_pressed("left_click") and cooldown_timer.time_left <= 0 and !teleport_collision_check.is_overlapping_body():
		player.teleport_to_given_pos(global_position)
		tele_sfx.play()
		disable()
	time_left_label.text = str(int(cooldown_timer.time_left))

func get_distance_to_player():
	return (global_position - player.global_position).length()

func disable():
	disabled = true
	modulate.a = 0.1
	cooldown_timer.start()

func enable():
	disabled = false
	modulate.a = 1.0
