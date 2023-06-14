extends CharacterBody2D


enum State {
	ACTION,
	IDLE,
	MOVE,
}


@export var acceleration = 640
@export var friction = 320
@export var speed = 64

var state = State.IDLE
var input_vector = Vector2.ZERO

@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

@onready var main_sprite = $MainSprite
@onready var action_sprite = $ActionSprite


func _ready():
	action_sprite.visible = false
	animation_tree.active = true


func _process(delta):
	select_state()
	get_input_vector()
	update_animations()


func _physics_process(delta):
	update_velocity(delta)
	move_and_slide()


func select_state():	
	if Input.is_action_just_pressed("game_action"):
		state = State.ACTION
	
	if state == State.ACTION:
		return
	
	if input_vector != Vector2.ZERO:
		state = State.MOVE
	else:
		state = State.IDLE


func get_input_vector():
	if state != State.ACTION:
		input_vector = Vector2(
			Input.get_action_strength("game_right") - Input.get_action_strength("game_left"),
			Input.get_action_strength("game_down") - Input.get_action_strength("game_up")
		).normalized()


func update_animations():
	if state == State.ACTION:
		action_sprite.visible = true
		main_sprite.visible = false
	else:
		action_sprite.visible = false
		main_sprite.visible = true
		
	match state:
		State.ACTION:
			animation_state.travel("Axe")
		State.IDLE:
			animation_state.travel("Idle")
		State.MOVE:
			animation_state.travel("Walk")
	
	if input_vector != Vector2.ZERO:
		animation_tree.set("parameters/Axe/blend_position", input_vector)
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Walk/blend_position", input_vector)


func update_velocity(delta):
	if state == State.ACTION:
		velocity = Vector2.ZERO
	elif input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)


func _on_animation_tree_animation_finished(_anim_name):
	state = State.IDLE
