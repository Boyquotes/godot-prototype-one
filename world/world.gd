extends Node2D


@onready var hud := $UI/HUD
@onready var player := $Entities/Player
@onready var player_menu := $UI/PlayerMenu
@onready var chest_interface := $UI/ChestInterface


func _ready() -> void:
	hud.player = player
	player_menu.player = player
	chest_interface.player = player


func _on_chest_open(chest: Chest) -> void:
	chest_interface.chest = chest
	chest_interface.visible = true
