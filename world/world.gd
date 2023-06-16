extends Node2D


@onready var player = $Entities/Player
@onready var player_menu = $PlayerMenu


func _ready():
	player_menu.player = player
