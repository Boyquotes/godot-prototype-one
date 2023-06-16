extends Control


@onready var inventory = $MarginContainer/CenterContainer/Inventory

var player: Player: set = set_player


func _ready():
	visible = false


func _process(_delta):
	if Input.is_action_just_pressed("game_player_menu"):
		toggle_player_menu()


func set_player(new_player: Player):
	player = new_player
	inventory.populate_slot_grid(player.inventory_data.slot_data_list)


func toggle_player_menu():
	visible = !visible
