extends "res://datatypes/items.gd"

# equipment types
const Weapon = 0
const Armor = 1
const Helmet = 2
const Foot = 3
const Shield = 4
const Accessory = 5

# instance definition
var slot
var strength
var defense
var vitality
var durability

func use():
	# uses the equipment in combat, which may reduce its durability
	# @return True if the equipment can still be used, False if it should be removed from the user's equipment
	if randf() > .7:
		durability = max(0, durability - 1)
	return durability > 0
