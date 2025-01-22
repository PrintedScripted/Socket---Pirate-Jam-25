extends Area2D

class_name Projectile

@export var lifespan: float = 2
@export var speed: float = 50.0
@export var damage: float = 1000.0
var spawned_from: Node

func _physics_process(_delta: float) -> void:
	position += -transform.y * speed

func _ready() -> void:
	body_entered.connect(on_body_entered)
	await get_tree().create_timer(lifespan).timeout
	queue_free()
	
func on_body_entered(body: Node2D) -> void:
	if body == spawned_from: return
	if body is Enemy:
		var enemy: Enemy = body as Enemy
		enemy.apply_damage(damage)
	queue_free()
