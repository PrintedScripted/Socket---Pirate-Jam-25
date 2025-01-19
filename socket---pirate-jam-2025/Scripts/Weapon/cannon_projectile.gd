extends Area2D

class_name Projectile

var lifespan: float = 2
var speed: float = 50.0

func _physics_process(_delta: float) -> void:
	position += transform.x * speed

func _ready() -> void:
	body_entered.connect(on_body_entered)
	await get_tree().create_timer(lifespan).timeout
	queue_free()
	
	
func on_body_entered(body: Node2D) -> void:
	print(body.name)
