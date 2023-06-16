class_name SlotData extends Resource


const MAX_STACK_SIZE := 99

@export var item_data: ItemData
@export_range(1, MAX_STACK_SIZE) var stack_size := 1:
	set = set_stack_size


func set_stack_size(value: int):
	if !item_data.stackable && value > 1:
		push_error("%s is not stackable, setting stack size to 1" % item_data.name)
		stack_size = 1
		return
	
	if value > MAX_STACK_SIZE:
		push_error("Stack size %s is bigger than max %s, skipping set" % [value, MAX_STACK_SIZE])
		return
	
	stack_size = value
