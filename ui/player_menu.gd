extends Control


@onready var inventory := $MarginContainer/CenterContainer/Inventory

var player: Player:
	set(value):
		player = value
		inventory.inventory_data = player.inventory_data


func _ready() -> void:
	visible = false


func _process(_delta: float) -> void:
	handle_input()


func handle_input():
	if Input.is_action_just_pressed("game_player_menu"):
		toggle_visible()


func toggle_visible() -> void:
	visible = !visible
