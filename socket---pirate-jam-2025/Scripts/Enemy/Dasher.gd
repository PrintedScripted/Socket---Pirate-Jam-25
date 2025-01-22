class_name Dasher extends Enemy

@export var circle_distance: int = 300

func _physics_process(delta: float) -> void:
	var distance = position.distance_to(Vector2(0,0))
	velocity = position.direction_to(Vector2(0,0)) * speed * delta
	if distance > circle_distance:
		move_and_slide()
	else:
		pass
	look_at(Vector2(0,0))
	rotation_degrees += 90
