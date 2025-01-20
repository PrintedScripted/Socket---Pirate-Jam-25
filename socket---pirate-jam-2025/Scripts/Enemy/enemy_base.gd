class_name Enemy extends CharacterBody2D


@export var speed: float = 30000.0
@export var max_health: float = 100.0
@export var weight: float = 100.0
@export var h_scaling: float
@export var speed_scaling: float
var health: float
var target: Player

func _ready() -> void:
#	health = max_health * h_scaling
	speed = clamp(speed * speed_scaling * 1000, 500, 15000)
	print(speed_scaling)

#func _physics_process(delta: float) -> void:
	#if target == null:
		#target = get_tree().get_nodes_in_group("Player")[0]
	#if target != null:
		#velocity = position.direction_to(target.position) * speed * delta
		#move_and_slide()
		#look_at(target.global_position)
		#rotation_degrees += 90
	#

func apply_damage(damage: float) -> void:
	health = clamp(health - damage, 0.0, 100.0)
	if health == 0:
		GameManager.handle_enemy_death()
		queue_free()
