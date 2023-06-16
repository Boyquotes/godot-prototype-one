extends CanvasLayer

@onready var hotbar = $Control/Hotbar


func _process(_delta):
	if Input.is_action_just_pressed("game_player_menu"):
		toggle_hotbar()


func set_player(player: Player):
	hotbar.set_player_inventory_data(player.inventory_data)


func toggle_hotbar():
	hotbar.visible = !hotbar.visible
