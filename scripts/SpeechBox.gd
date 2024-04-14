extends VBoxContainer

@export_multiline var speaker = "Default speaker"
@export_multiline var dialogue = "This is some debug dialogue"
@onready var anim_player = $AnimationPlayer
@onready var speaker_text = $Speaker
@onready var speech_text = $Speech
var disabled = false

enum DIALOGUE_TYPE {intro,victory,defeat}
@export var lines_to_say : DIALOGUE_TYPE

signal dialogue_over

var lines = []

var lines_intro = [
["Demon Boss","You have been slacking.",1],
["Demon Boss","Not responding to summonings? How do you expect us to keep running this bussiness?",0.5],
["Demon Boss","One last chance.",1],
["Demon Boss","You have one last chance to prove yourself.",1],
["Demon Boss","I will be watching.",1],
["Demon Boss","If you make me lose a single penny today you are [wave]FIRED[/wave].",1],
["Demon Boss","Do you understand?",1],
["Demon Boss","Now go.",1],
["Demon Boss","You got work to do.",1],
["","Press SPACE to end dialogue.",10],
]

var lines_victory = [
["Demon Boss","You have proven yourself worthy.",1],
["Demon Boss","You are not fired.",1],
["Demon Boss","For now.",2],
["Demon Boss","Go home.",2],
["Demon Boss","Have some rest.",1],
["Demon Boss","Oh, before you go.",1],
["Demon Boss","...",2],
["Demon Boss","I knew you could do it.",1],
["Demon Boss","I really did.",1],
["Demon Boss","...",2],
["Demon Boss","And uh...",2],
["Demon Boss","Thanks. I really mean it.",1],
["","Press SPACE to end dialogue.",10],
]

#["Demon Boss","Here is some text I'm supposed to read.",1],
#["Demon Boss","Ahem,",1],
#["Demon Boss","\"This game was made in 48 hours for Ludum Dare 55...",1],
#["Demon Boss","Thank you for playing.\"",1],
#["Demon Boss","Yeah whatever that's supposed to mean",1],
#["Demon Boss","Anyways bye",4],
#["Demon Boss","Leave.",4],
#["Demon Boss","Go away.",4],
#["Demon Boss","...",4],
#["Demon Boss","Bye.",4],
#["Developer","(you can leave.)",4],
#["Developer","(no more secret dialogue.)",4],
#["Developer","(I promise.)",4],
#]

var lines_defeat = [
["Demon Boss","You have failed in your mission.",1],
["Demon Boss","You are [wave]FIRED[/wave].",1],
["Demon Boss","Pack your stuff and leave.",1],
["Demon Boss","Well you don't have stuff...",1],
["Demon Boss","You can just leave.",1],
["Demon Boss","Go to the overworld.",1],
["Demon Boss","Find a job there maybe...",1],
["Demon Boss","I don't care.",1],
["Demon Boss","Bye...",1],
["Developer","(or try again?)",1],
["Developer","(act like this never happened?)",1],
["Developer","(that's always an option y'know.)",1],
["Developer","(but it's ok if you don't wanna.)",1],
["Developer","(Thanks for playing anyways.)",1],
["","Press SPACE to end dialogue.",10],
]

var current_line = -1

func _ready():
	match lines_to_say:
		DIALOGUE_TYPE.intro:
			lines = lines_intro
		DIALOGUE_TYPE.victory:
			lines = lines_victory
		DIALOGUE_TYPE.defeat:
			lines = lines_defeat
	trigger_next_dialogue()

func _process(delta):
	if disabled:
		return
	if Input.is_action_just_pressed("ui_accept"):
		if current_line >= len(lines)-1:
			dialogue_over.emit()
		if current_line >= len(lines)-1:
			disabled = true
			visible = false
			return
		if !anim_player.is_playing():
			trigger_next_dialogue()
		else:
			anim_player.speed_scale = 10

func display_next_dialogue():
	current_line += 1
	if current_line >= len(lines):
		return
	speaker_text.text = "[font_size=70]" + lines[current_line][0] + "[/font_size]    " + "[font_size=20][wave]press SPACE to continue...[/wave][/font_size]"
	speech_text.text = "[font_size=40]" + lines[current_line][1] + "[/font_size]"
	anim_player.speed_scale = lines[current_line][2]

func clear_current_dialogue():
	speech_text.text = ""

func trigger_next_dialogue():
	anim_player.play("text_appear")
