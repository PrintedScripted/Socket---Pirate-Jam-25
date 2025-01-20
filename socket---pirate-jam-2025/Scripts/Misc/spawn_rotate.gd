extends Marker2D

var trigger: int = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	trigger += 1
	if trigger % 2 == 0:
		rotation_degrees += 1
		if rotation_degrees == 360:
			@warning_ignore("standalone_expression")
			rotation_degrees == 0
			
