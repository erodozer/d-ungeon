extends Spatial

var player
var dungeon

func _ready():
	player = get_node("/root/player")
	dungeon = get_node("/root/dungeon")

func _process(delta):
	if Input.is_action_pressed("ui_down"):
		var p = get_translation()
		set_translation(Vector3(p.x, p.y, p.z - 1))
	if Input.is_action_pressed("ui_up"):
		var p = get_translation()
		set_translation(Vector3(p.x, p.y, p.z + 1))
	if Input.is_action_pressed("ui_left"):
		var p = get_rotation()
		set_rotation(Vector3(p.x, p.y, p.z - 1))
	if Input.is_action_pressed("ui_right"):
		var p = get_rotation()
		set_rotation(Vector3(p.x, p.y, p.z - 1))
