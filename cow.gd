extends CharacterBody2D


const ACCELERATION = 800
const FRICTION = 400
const SPEED = 100

@onready var animated_sprite = $AnimatedSprite2D


func _ready():
	start_idle_timer()


func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_slide()


func _on_timer_timeout():
	animated_sprite.play("idle")
	start_idle_timer()


func start_idle_timer():
	$Timer.start(randi_range(1, 3))
