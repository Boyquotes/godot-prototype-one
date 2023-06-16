class_name Chest extends StaticBody2D


signal open(chest: Chest)


const DEFAULT_INVENTORY_SIZE := 30

var inventory_data := InventoryData.new(DEFAULT_INVENTORY_SIZE)

@onready var animated_sprite := $AnimatedSprite2D
@onready var scene := get_tree().current_scene


func _ready() -> void:
	open.connect(scene._on_chest_open)


func _on_interaction_hitbox_area_entered(_area: Area2D) -> void:
	animated_sprite.play("open")
	open.emit(self)


func close() -> void:
	animated_sprite.play_backwards("open")
