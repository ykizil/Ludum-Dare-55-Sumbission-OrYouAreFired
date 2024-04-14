extends ProgressBar

var pentas_done = 0
var pentas_failed = 0
@onready var player_icon = $PlayerIcon

var game_progress = pentas_done - pentas_failed

signal victory_achieved
signal defeated

func _ready():
	$%EventBus.penta_activated.connect(on_penta_activated)
	$%EventBus.penta_failed.connect(on_penta_failed)
	

func _process(delta):
	game_progress = pentas_done - pentas_failed
	value = 50 + game_progress*10
	player_icon.position.x = value*size.x/100
	if value >= 99:
		victory_achieved.emit()
		await get_tree().create_timer(1).timeout
		var victory_scene = load("res://scenes/victory_screen.tscn")
		get_tree().change_scene_to_packed(victory_scene)
	if value <= 1:
		defeated.emit()
		await get_tree().create_timer(1).timeout
		var defeat_scene = load("res://scenes/defeat_screen.tscn")
		get_tree().change_scene_to_packed(defeat_scene)

func on_penta_activated():
	pentas_done += 1

func on_penta_failed():
	pentas_failed += 1
