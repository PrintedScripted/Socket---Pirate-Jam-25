class_name Dasher extends Enemy

@export var circle_distance: int = 300
var circle_dir: int

func _physics_process(delta: float) -> void:
	var distance = position.distance_to(Vector2(0,0))
	velocity = position.direction_to(Vector2(0,0)) * speed * delta
	if distance > circle_distance:
		move_and_slide()
	else:
		circle_positioning()
	look_at(Vector2(0,0))
	rotation_degrees += 90

func circle_positioning():
	if position.x =< 0: pass
	elif position.x => 0: 
	elif position.y =< 0:
	elif position.y =>
