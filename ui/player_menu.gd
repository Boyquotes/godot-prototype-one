extends Control


@onready var inventory := $MarginContainer/CenterContainer/Inventory

var player: Player:
	set(value):
		player = value
		inventory.populate_slot_grid(player.inventory_data.slot_data_list)


func _ready() -> void:
	visible = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("game_player_menu"):
		toggle_player_menu()


func toggle_player_menu() -> void:
	visible = !visible
