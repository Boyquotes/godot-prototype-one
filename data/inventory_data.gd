class_name InventoryData extends Resource


@export var slot_data_list: Array[SlotData] = []


func _init(size: int = 10) -> void:
	if size < 1:
		push_error("inventory size cannot be smaller than 1")
		size = 1
	slot_data_list.resize(size)
