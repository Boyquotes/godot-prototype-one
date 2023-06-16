extends Control

@onready var chest_inventory := $MarginContainer/CenterContainer/VBoxContainer/ChestInventory
@onready var player_inventory := $MarginContainer/CenterContainer/VBoxContainer/PlayerInventory

var chest: Chest:
	set(value):
		chest = value
		chest_inventory.inventory_data = chest.inventory_data

var player: Player:
	set(value):
		player = value
		player_inventory.inventory_data = player.inventory_data


func _ready() -> void:
	visible = false


func _process(_delta: float) -> void:
	handle_escape()


func handle_escape() -> void:
	if Input.is_action_just_pressed("game_escape") and visible and chest:
		chest.handle_close()
		visible = false
