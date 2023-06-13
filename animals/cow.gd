extends CharacterBody2D


enum State {
	IDLE,
	MOVE,
}


@export var acceleration = 100
@export var friction = 100
@export var speed = 10

@export var min_idle_time = 2
@export var max_idle_time = 3
@export var min_move_time = 1
@export var max_move_time = 2

var state = State.IDLE
var input_vector = Vector2.ZERO

@onready var animated_sprite = $AnimatedSprite2D


func _ready():
	get_input_vector()
	start_timer()


func _physics_process(delta):
	update_velocity(delta)
	update_animations()
	move_and_slide()


func _on_timer_timeout():
	select_state()
	get_input_vector()
	start_timer()


func start_timer():
	var timeout
	match state:
		State.IDLE:
			timeout = randf_range(min_idle_time, max_idle_time)
		State.MOVE:
			timeout = randf_range(min_move_time, max_move_time)
	$Timer.start(timeout)


func select_state():
	if state == State.MOVE:
		state = State.IDLE
	else:
		state = randi_range(State.IDLE, State.MOVE)


func get_input_vector():
	input_vector = Vector2(
		randi_range(-1, 1),
		randi_range(-1, 1),
	)


func update_animations():
	if velocity == Vector2.ZERO:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("move")
	
	if input_vector.x != 0:
		animated_sprite.flip_h = input_vector.x < 0


func update_velocity(delta):
	match state:
		State.IDLE:
			velocity = Vector2.ZERO
		State.MOVE:
			if input_vector != Vector2.ZERO:
				velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
			else:
				velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
