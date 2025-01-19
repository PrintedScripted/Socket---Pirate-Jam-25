extends CharacterBody2D

class_name Enemy

var speed: float = 100.0
var health: float = 100.0
var target: Player

func _physics_process(delta: float) -> void:
	if target == null:
		target = get_tree().get_nodes_in_group("Player")[0]
	if target != null:
		velocity = position.direction_to(target.position) * speed * delta
		move_and_slide()
		look_at(target.global_position)
		rotation_degrees += 90
