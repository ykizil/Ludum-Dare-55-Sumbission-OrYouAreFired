extends Area2D

@export var summon_ready = false
@onready var anim_player = $AnimationPlayer
@onready var patience_timer = $PatienceTimer
@onready var time_left_label = $TimeLeftLabel
@export var summon_patience = 15

var is_player_overlapping = false

func _ready():
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	patience_timer.timeout.connect(toggle_summon_ready)
	init_summon_ready()

func _process(delta):
	update_time_left()
	if is_player_overlapping and summon_ready:
		goal_achieved()

func on_body_entered(body):
	if body is Player or Player in get_overlapping_bodies():
		is_player_overlapping = true

func on_body_exited(body):
	if body is Player:
		is_player_overlapping = false

func goal_achieved():
	penta_activated()
	summon_set_unready()
	anim_player.play("summon_answered")

func penta_activated():
	modulate = Color(1,0,0,1)
	$%EventBus.penta_activated.emit()

func summon_set_ready():
	summon_ready = true
	modulate = Color(1,1,1,1)
	patience_timer.start(summon_patience + randf_range(5,10))

func summon_set_unready():
	summon_ready = false
	#modulate = Color(1,1,1,0.1)
	patience_timer.start(7 + randf_range(3,8))

func toggle_summon_ready():
	if summon_ready:
		summon_set_unready()
		$%EventBus.penta_failed.emit()
		anim_player.play("summon_failed")
	else:
		summon_set_ready()

func init_summon_ready():
	if summon_ready == false:
		summon_set_unready()
	else:
		summon_set_ready()

func update_time_left():
	time_left_label.text = str(int(patience_timer.time_left))
