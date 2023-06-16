extends CharacterBody2D


enum State {
	IDLE,
	MOVE,
}


@export var acceleration := 128
@export var friction := 64
@export var speed := 32

@export var min_idle_time := 2
@export var max_idle_time := 3
@export var min_move_time := 1
@export var max_move_time := 2

var state := State.IDLE
var input_vector := Vector2.ZERO

@onready var animated_sprite := $AnimatedSprite2D
@onready var timer := $Timer


func _ready() -> void:
	get_input_vector()
	start_timer()


func _physics_process(delta: float) -> void:
	update_velocity(delta)
	update_animations()
	move_and_slide()
	if velocity == Vector2.ZERO:
		state = State.IDLE


func _on_timer_timeout() -> void:
	select_state()
	get_input_vector()
	start_timer()


func start_timer() -> void:
	var timeout
	match state:
		State.IDLE:
			timeout = randf_range(min_idle_time, max_idle_time)
		State.MOVE:
			timeout = randf_range(min_move_time, max_move_time)
	timer.start(timeout)


func select_state() -> void:
	if state == State.MOVE:
		state = State.IDLE
	else:
		state = randi_range(State.IDLE, State.MOVE) as State


func get_input_vector() -> void:
	input_vector = Vector2(
		randi_range(-1, 1),
		randi_range(-1, 1),
	)


func update_animations() -> void:
	if velocity == Vector2.ZERO:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("move")
	
	if input_vector.x != 0:
		animated_sprite.flip_h = input_vector.x < 0


func update_velocity(delta: float) -> void:
	match state:
		State.IDLE:
			velocity = Vector2.ZERO
		State.MOVE:
			if input_vector != Vector2.ZERO:
				velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
			else:
				velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
