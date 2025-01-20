extends CharacterBody2D

class_name Player

@export var projectile: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	look_at(get_global_mouse_position());
	rotation_degrees += 90
	if Input.is_action_just_pressed("Trigger_Main_Attack"): shoot()

func shoot() -> void:
	var inst: Projectile = projectile.instantiate()
	inst.spawned_from = self
	owner.add_child(inst)
	inst.transform = $Center/Projectile_Spawn1.global_transform
