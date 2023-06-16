extends Area2D


@onready var tilemap := $TileMap


func _ready() -> void:
	tilemap.set_layer_enabled(2, true)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		tilemap.set_layer_enabled(2, false)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		tilemap.set_layer_enabled(2, true)
