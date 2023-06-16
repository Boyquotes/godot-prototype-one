extends Control


@onready var hotbar = $Hotbar

var player: Player:
	set(value):
		player = value
		hotbar.set_inventory_data(player.inventory_data)


func _process(_delta: float) -> void:
	handle_input()


func handle_input():
	if Input.is_action_just_pressed("game_player_menu"):
		toggle_hotbar_visible()


func toggle_hotbar_visible() -> void:
	hotbar.visible = !hotbar.visible
