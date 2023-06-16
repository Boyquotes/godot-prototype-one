extends MarginContainer


@onready var inventory := $Inventory


func set_player_inventory_data(inventory_data: InventoryData) -> void:
	var inventory_slice = inventory_data.slot_data_list.slice(0, 10)
	inventory.populate_slot_grid(inventory_slice)
