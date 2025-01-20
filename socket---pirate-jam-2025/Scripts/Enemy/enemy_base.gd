class_name Enemy extends CharacterBody2D

@export var speed: float = 30000.0
@export var max_health: float = 100.0
@export var weight: float = 100.0
@export var h_scaling: float
@export var speed_scaling: float
var health: float
@export var target: Vector2 = Vector2(0,0)

func _ready() -> void:
	health = max_health * GameManager.enemy_health_scaling
	speed = clamp(speed * GameManager.enemy_speed_scaling * 10000, 500, 15000)

func _physics_process(delta: float) -> void:
	velocity = position.direction_to(Vector2(0,0)) * speed * delta
	move_and_slide()
	look_at(Vector2(0,0))
	rotation_degrees += 90

func apply_damage(damage: float) -> void:
	health = clamp(health - damage, 0.0, 100.0)
	if health == 0:
		GameManager.handle_enemy_death()
		queue_free()
