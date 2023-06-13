extends Area2D


@onready var tilemap = $TileMap


func _ready():
	tilemap.set_layer_enabled(2, true)


func _on_body_entered(body):
	if body.name == "Player":
		tilemap.set_layer_enabled(2, false)


func _on_body_exited(body):
	if body.name == "Player":
		tilemap.set_layer_enabled(2, true)

