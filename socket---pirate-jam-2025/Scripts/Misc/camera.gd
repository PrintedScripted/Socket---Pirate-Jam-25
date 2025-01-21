extends Camera2D
class_name Camera

enum MODES { TARGET_MOUSE_BLENDED }

@export var target: Node = null
@export var mode: MODES = MODES.TARGET_MOUSE_BLENDED
@export var MAX_DISTANCE: float = 50.0
@export var SMOOTH_SPEED: float = 5.0

var target_position := Vector2.INF
var fallback_target: Node = target

func _ready():
	fallback_target = target
	
func _process(delta: float):
	match(mode):
		MODES.TARGET_MOUSE_BLENDED:
			if target:
				var mouse_pos := get_local_mouse_position()
				target_position = (target.position + mouse_pos)
				target_position.x = clamp(target_position.x, -MAX_DISTANCE + target_position.x, MAX_DISTANCE + target_position.x)
				target_position.y = clamp(target_position.y, -MAX_DISTANCE + target_position.y, MAX_DISTANCE + target_position.y)
		
	if target_position != Vector2.INF:
		position = lerp(position, target_position /2, SMOOTH_SPEED * delta)
