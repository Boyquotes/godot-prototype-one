extends CharacterBody2D


enum State {
	ACTION,
	IDLE,
	MOVE,
}


@export var acceleration = 800
@export var friction = 400
@export var speed = 100

var state = State.MOVE
var input_vector = Vector2.ZERO

@onready var animated_sprite = $AnimatedSprite2D


func _ready():
	start_idle_timer()


func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	move_and_slide()


func _on_timer_timeout():
	animated_sprite.play("idle")
	start_idle_timer()


func start_idle_timer():
	$Timer.start(randi_range(1, 3))
