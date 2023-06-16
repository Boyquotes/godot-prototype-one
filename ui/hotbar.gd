extends MarginContainer


const SLOT_COUNT := 10

var inventory_size := 0
var slot_offset := 0

var inventory_data: InventoryData:
	set = set_inventory_data

@onready var inventory := $Inventory


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("game_hotbar_next"):
		next_row()
	if Input.is_action_just_pressed("game_hotbar_previous"):
		previous_row()


func set_inventory_data(data: InventoryData) -> void:
	inventory_data = data
	var slice = slice_inventory()
	inventory.populate_slot_grid(slice)


func slice_inventory() -> Array[SlotData]:
	var start := slot_offset
	var end := slot_offset + SLOT_COUNT
	return inventory_data.slot_data_list.slice(start, end)


func next_row():
	slot_offset += SLOT_COUNT
	while slot_offset >= inventory_size:
		slot_offset -= SLOT_COUNT


func previous_row():
	slot_offset -= SLOT_COUNT
	while slot_offset < 0:
		slot_offset += SLOT_COUNT
