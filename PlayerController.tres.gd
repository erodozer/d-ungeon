extends Spatial

var player
var dungeon
var tween
var _pause_input = false

const MOVEMENT_SCALE = 1

func _ready():
	player = get_node("/root/player")
	dungeon = get_node("/root/dungeon")
	set_process(true)
	set_process_input(true)
	tween = get_node("Tween")
	
func _resume_input():
	# resume paused input from the tween animation
	set_process_input(true)
	
func _move(direction):
	# moves the camera forward or backwards through the dungeon
	set_process_input(false)
	var forward = get_transform().basis.z * direction
	tween.interpolate_property(self, "transform/translation", get_translation(), get_translation() + forward, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_callback(self, .5, "_resume_input")
	tween.start()
	
func _turn(direction):
	# turns the camera 90 degress to perform a turn
	set_process_input(false)
	var p = get_rotation_deg() 
	tween.interpolate_property(self, "transform/rotation", p, Vector3(p.x, p.y + (direction * 90), p.z), .8, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_callback(self, .8, "_resume_input")
	tween.start()

func _input(event):
	if event.is_action("ui_up"):
		_move(-1)
	if event.is_action("ui_down"):
		_move(1)
	if event.is_action("ui_left"):
		_turn(1)
	if event.is_action("ui_right"):
		_turn(-1)

func _process(delta):
	pass
