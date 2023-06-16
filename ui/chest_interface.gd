extends Control

@onready var chest_inventory := $MarginContainer/CenterContainer/VBoxContainer/ChestInventory
@onready var player_inventory := $MarginContainer/CenterContainer/VBoxContainer/PlayerInventory

var chest: Chest:
	set(value):
		chest = value
		chest_inventory.populate_slot_grid(chest.inventory_data.slot_data_list)

var player: Player:
	set(value):
		player = value
		player_inventory.populate_slot_grid(player.inventory_data.slot_data_list)


func _ready() -> void:
	visible = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("game_escape"):
		chest.close()
		visible = false
