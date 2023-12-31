extends PanelContainer


const Slot := preload("res://ui/slot.tscn")

@onready var slot_grid := $MarginContainer/SlotGrid

var inventory_data: InventoryData:
	set = set_inventory_data


func set_inventory_data(inventory_data: InventoryData) -> void:
	populate_slot_grid(inventory_data.slot_data_list)


func populate_slot_grid(slot_data_list: Array[SlotData]) -> void:
	for slot in slot_grid.get_children():
		slot.queue_free()
	
	for slot_data in slot_data_list:
		var slot = Slot.instantiate()
		slot_grid.add_child(slot)
		
		if slot_data:
			slot.set_data(slot_data)
