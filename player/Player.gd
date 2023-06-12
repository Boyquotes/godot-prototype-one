extends CharacterBody2D


signal move(position)

enum {
	MOVE,
	ACTION,
}

const ACCELERATION = 800
const FRICTION = 400
const SPEED = 100

var state = MOVE

@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

@onready var main_sprite = $MainSprite
@onready var action_sprite = $ActionSprite


func _ready():
	action_sprite.visible = false
	animation_tree.active = true


func _physics_process(delta):
	match state:
		ACTION:
			handle_action()
		MOVE:
			handle_move(delta)


func handle_action():
	action_sprite.visible = true
	main_sprite.visible = false
	animation_state.travel("Axe")
	velocity = Vector2.ZERO


func handle_move(delta):
	action_sprite.visible = false
	main_sprite.visible = true
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("game_right") - Input.get_action_strength("game_left")
	input_vector.y = Input.get_action_strength("game_down") - Input.get_action_strength("game_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animation_state.travel("Walk")
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Walk/blend_position", input_vector)
		animation_tree.set("parameters/Axe/blend_position", input_vector)
		velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move_and_slide()
	
	move.emit(transform)
	
	if Input.is_action_just_pressed("game_action"):
		state = ACTION


func _on_animation_tree_animation_finished(anim_name):
	state = MOVE
