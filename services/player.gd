extends Node

var Item = preload('res://datatypes/items.gd')
var Equipment = preload('res://datatypes/equipment.gd')

class Facing:
	const NORTH = 90
	const SOUTH = 270
	const EAST = 0
	const WEST = 180

const INVENTORY_LIMIT = 100

var worn = {
	Equipment.Weapon: null,
	Equipment.Armor : null,
	Equipment.Helmet: null,
	Equipment.Accessory: null,
	Equipment.Foot: null,
	Equipment.Shield: null,
}

var slots = [null, null, null, null]

var _strength = 0
var _defense = 0
var _vitality = 0
var inventory = []

# how far down the player is in the dungeon
var depth = 0
var x = 0
var y = 0
var direction = Facing.NORTH

func equip(item, slot_index = 0):
	# manage equipping items and removing them from your inventory
	var equipped
	if item.slot == Equipment.Weapon:
		if slot_index != 0:
			# weapon must be in slot 0
			equipped = false
		else:
			inventory.remove(item)
			worn[item.slot] = item
			slots[slot_index] = item
			equipped = true
	else:
		# if an armor of a specific type has already been equipped, only allow replacing it,
		# as a way of preventing more than one of the same time of equipment from being worn
		if worn[item.slot] != null:
			if slots[slot_index] != worn[item.slot]:
				equipped = false
			else:
				inventory.remove(item)
				unequip(slot_index)
				worn[item.slot] = item
				slots[slot_index] = item
				equipped = true
		else:
			if slots[slot_index] != null:
				unequip(slot_index)
			worn[item.slot] = item
			slots[slot_index] = item
			equipped = true
			
	if equipped:
		# recalculate stats
		_strength = 0
		_defense = 0
		_vitality = 0
		for e in slots:
			_strength += e.strength
			_defense += e.defense
			_vitality += e.vitality
	return equipped

func unequip(slot_index):
	# returns an item to the player's inventory
	var item = slots[slot_index]
	slots[slot_index] = null
	worn[item.slot] = null
	inventory.append(item)

func destory_equipment(item):
	# unequip item and remove it from the inventory, as it should be scrapped
	unequip(slots.find(item))
	inventory.remove(item)

func get_strength():
	return _strength
	
func get_defense():
	return _defense
	
func get_vitality():
	return _vitality
	
func pickup(item):
	# add an item into the player's inventory
	# @return True if the item could fit in the player's inventory
	if inventory.length < INVENTORY_LIMIT:
		inventory.append(item)
		return true
	return false
