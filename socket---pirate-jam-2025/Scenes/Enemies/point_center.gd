extends Sprite2D

var move: int =  1;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	look_at(Vector2(0,0))
	rotation_degrees += 90
	set_position(Vector2(move, 50))
	move += 1
