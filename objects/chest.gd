extends StaticBody2D


@onready var animated_sprite = $AnimatedSprite2D


func _on_interaction_hitbox_area_entered(_area):
	animated_sprite.play("open")


func _on_interaction_hitbox_area_exited(_area):
	animated_sprite.play_backwards("open")
