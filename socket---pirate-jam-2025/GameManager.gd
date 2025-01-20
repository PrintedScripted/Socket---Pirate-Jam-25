extends Node

#Enemy Variables
@onready var enemy_striker: PackedScene = load("res://Scenes/Enemies/Striker.tscn")
@onready var enemy_warper: PackedScene = load("res://Scenes/Enemies/Warper.tscn")
@onready var enemy_dasher: PackedScene = load("res://Scenes/Enemies/Dasher.tscn")
var enemies_remaining: int = 2
var spawnpoints: Array[Node] = []
var wave: int = 1
var enemy_spawn_count: int = 0
var enemy_spawn_timer: Timer
var enemy_spawnrate: float = 2.5  #Scale from Difficulty
var rand_spawn_chance: int
var enemy_inst
var group_size: int = 2  #Scale from Difficulty
var enemy_health_scaling: float = 1.0 #Scale from Difficulty
var enemy_speed_scaling: float = 1.0 #Scale from Difficulty

var weighted_spawn: Array[int] = [50, 35, 15]
var weight_total: int = 0

#Resource Variables
#@onready var resource_node: PackedScene = load()
var resourcespawns: Array[Node] = []
var resource_spawn_timer: Timer
var resource_spawnrate: float = 3.0 #Scale from Difficulty
var resource_inst
var resource_count: int = 0

#Other Variables
var level: Node2D
var scaling_speed: float = 0.001 #Scale from Difficulty



#Launch Sequence

func _ready() -> void:
	level = get_tree().get_first_node_in_group("Level")
	resourcespawns = level.get_tree().get_nodes_in_group("SpawnResource")
	spawnpoints = level.get_tree().get_nodes_in_group("Spawn")
	initialize_resource_spawn_timer()
	initialize_enemy_spawn_timer()
	spawn_enemies()
	handle_next_wave()



#Enemy spawnhandler

func initialize_enemy_spawn_timer() -> void:
	enemy_spawn_timer = Timer.new()
	add_child(enemy_spawn_timer)
	enemy_spawn_timer.wait_time = enemy_spawnrate
	enemy_spawn_timer.one_shot = false
	enemy_spawn_timer.timeout.connect(spawn_enemies)

func handle_next_wave() -> void:
	enemy_spawn_count = 0
	enemy_spawn_timer.start()

func handle_enemy_death() -> void:
	scaling()

	handle_next_wave()

func spawn_enemies():
	var random_spawn: Node2D = spawnpoints[randi_range(0, spawnpoints.size() - 1)]
	weight_total = weighted_spawn[0]+weighted_spawn[1]+weighted_spawn[2]
	
	for i in range(0, group_size):
		rand_spawn_chance = randi_range(0, weight_total - 1)
		if i != group_size:
			if rand_spawn_chance > weighted_spawn[0]:
				enemy_inst = enemy_striker.instantiate()
			elif rand_spawn_chance > weighted_spawn[1]:
				enemy_inst = enemy_dasher.instantiate()
			elif rand_spawn_chance > weighted_spawn[2]:
				enemy_inst = enemy_warper.instantiate()
			
			if enemy_inst == null:
				pass
			elif enemy_inst != null:
				level.add_child(enemy_inst)
				enemy_inst.global_position = Vector2(random_spawn.global_position.x + randf_range(0.0, 200.0), random_spawn.global_position.y + randf_range(0.0, 200.0))
				enemy_spawn_count += 1
			
			if enemy_spawn_count == 250:
				enemy_spawn_timer.stop()



#Resource Spawnhandler
func initialize_resource_spawn_timer() -> void:
	resource_spawn_timer = Timer.new()
	add_child(resource_spawn_timer)
	resource_spawn_timer.wait_time = resource_spawnrate
	resource_spawn_timer.one_shot = false
	resource_spawn_timer.timeout.connect(spawn_resource)

func spawn_resource():
	var random_resource_spawn: Node2D = resourcespawns[randi_range(0, resourcespawns.size() - 1)]
	
	if resource_inst == null:
		pass
	elif resource_inst != null:
		level.add_child(resource_inst)
		resource_inst.global_position = random_resource_spawn.global_position
		resource_count += 1
	
	if resource_count == 250:
		resource_spawn_timer.stop()


#Scaling
func scaling() -> void:
	enemy_health_scaling = clamp(enemy_health_scaling + scaling_speed, 0.5, 1000.0)
	enemy_spawnrate = clamp(enemy_spawnrate - scaling_speed , 0.25, 15.0)
	enemy_speed_scaling = clamp(enemy_spawnrate + scaling_speed, 0.5, 1000.0)
	
	resource_spawnrate = clamp(resource_spawnrate + scaling_speed, 3.0, 60.0)
