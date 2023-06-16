class_name Player extends CharacterBody2D


enum State {
	ACTION,
	IDLE,
	MOVE,
}


@export var acceleration := 1280
@export var friction := 640
@export var speed := 128

var input_vector := Vector2.ZERO
var state := State.IDLE

@onready var animation_tree := $AnimationTree
@onready var animation_state: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

@onready var main_sprite := $MainSprite
@onready var action_sprite := $ActionSprite

@onready var interact_hitbox := $FeetPivot/InteractionHitbox/CollisionShape2D

const DEFAULT_INVENTORY_SIZE := 30

var inventory_data := InventoryData.new(DEFAULT_INVENTORY_SIZE)


func _ready() -> void:
	start_animation()


func _physics_process(delta: float) -> void:
	handle_interact()
	select_state()
	get_input_vector()
	update_animations()
	update_velocity(delta)
	move_and_slide()


func start_animation() -> void:
	animation_tree.active = true


func handle_interact() -> void:
	if Input.is_action_just_pressed("game_interact"):
		interact_hitbox.disabled = false
	elif Input.is_action_just_released("game_interact"):
		interact_hitbox.disabled = true


func select_state() -> void:
	if Input.is_action_just_pressed("game_action"):
		state = State.ACTION
	
	if state == State.ACTION:
		return
	
	if input_vector != Vector2.ZERO:
		state = State.MOVE
	else:
		state = State.IDLE


func get_input_vector() -> void:
	if state != State.ACTION:
		input_vector = Vector2(
			Input.get_action_strength("game_right") - Input.get_action_strength("game_left"),
			Input.get_action_strength("game_down") - Input.get_action_strength("game_up")
		).normalized()


func update_animations() -> void:
	match state:
		State.ACTION:
			animation_state.travel("Axe", false)
		State.IDLE:
			animation_state.travel("Idle", false)
		State.MOVE:
			animation_state.travel("Walk", false)
	
	if input_vector != Vector2.ZERO:
		animation_tree.set("parameters/Axe/blend_position", input_vector)
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Walk/blend_position", input_vector)


func update_velocity(delta: float) -> void:
	if state == State.ACTION:
		velocity = Vector2.ZERO
	elif input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)


func _on_animation_tree_animation_finished(_anim_name: StringName) -> void:
	state = State.IDLE
