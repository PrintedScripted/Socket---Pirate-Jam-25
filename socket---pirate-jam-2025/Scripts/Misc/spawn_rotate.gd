extends Marker2D


func _process(_delta: float) -> void:
	rotation_degrees += 1
	if rotation_degrees == 360:
		@warning_ignore("standalone_expression")
		rotation_degrees == 0
