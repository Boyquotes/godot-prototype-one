extends Node2D


@onready var hud = $UI/HUD
@onready var player = $Entities/Player
@onready var player_menu = $UI/PlayerMenu


func _ready():
	hud.set_player(player)
	player_menu.set_player(player)
