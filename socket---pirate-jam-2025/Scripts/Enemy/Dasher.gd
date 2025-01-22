class_name Dasher extends Enemy

@export var circle_distance: int = 300
var circle_dir: int

func _physics_process(delta: float) -> void:
	var distance = position.distance_to(Vector2(0,0))
	velocity = position.direction_to(Vector2(0,0)) * speed * delta
	if distance > circle_distance:
		move_and_slide()
	elif distance < circle_distance - 1:
		velocity = -velocity
		move_and_slide()
	else:
		circle_positioning()
	look_at(Vector2(0,0))
	rotation_degrees += 90

func circle_positioning():
	var posx = position.x
	var posy = position.y
	if posx < 1 and posy <= 0:
		velocity = Vector2(100,0)
	elif posx >= 0 and posy < 1:
		velocity = Vector2(0,100)
	elif posx > 1 and posy >= 0:
		velocity = Vector2(-100,0)
	elif posx <= 0 and posy > 1:
		velocity = Vector2(0,-100)
	move_and_slide()
