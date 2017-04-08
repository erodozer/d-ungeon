extends TileMap

var _path = ""
var _seed = 0
var _random = null

const FLOOR = 0
const WALL = 1
const HALL = 2 

var floors = []
var floor_seeds = []

func discover_floor(path):
	# each floor of the dungeon should be a different file
	if floors.find(path):
		return false
	
	floors.append(path)
	var f = File.new()
	floor_seeds.append(
		f.get_md5(path)
	)
	return true
	
func _generate(depth):
	# gerenates the tile map for the currently active floor
	var _seed = floor_seeds[depth]
	
	# generatess the layout of the floor dependent on the md5
	set_cell(0, 0, FLOOR)
	
func dungeon_complete():
	# dungeons are fully explored after 20 levels
	return floors.length >= 20
	
func _ready():
	# generate test dungeon
	set_cell(1, 0, 0)
	set_cell(1, 1, 0)
	set_cell(1, 2, 0)
	set_cell(0, 0, 1)
	set_cell(2, 0, 1)
	set_cell(0, 1, 1)
	set_cell(2, 1, 1)
	set_cell(0, 2, 1)
	set_cell(2, 2, 1)
