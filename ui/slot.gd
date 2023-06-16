extends PanelContainer


@onready var texture_rect := $MarginContainer/TextureRect
@onready var stack_size_label := $StackSizeLabel

var slot_data: SlotData:
	set = set_data


func set_data(slot_data: SlotData) -> void:
	var item_data := slot_data.item_data
	texture_rect.texture = item_data.texture
	tooltip_text = "%s/n%s" % [item_data.name, item_data.description]
	
	if slot_data.stack_size > 1:
		stack_size_label.text = slot_data.stack_size
