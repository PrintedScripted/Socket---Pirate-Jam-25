extends Node

@onready var enemy_striker: PackedScene = load("res://Scenes/Enemies/Striker.tscn")
@onready var enemy_warper: PackedScene = load("res://Scenes/Enemies/Warper.tscn")
@onready var enemy_dasher: PackedScene = load("res://Scenes/Enemies/Dasher.tscn")
var wave: int = 1
var enemies_remaining: int = 2
var spawn_count: int = 0
var spawnpoints: Array[Node] = []
var level: Node2D
var spawn_timer: Timer
var spawnrate: float = 2.5
var weighted_spawn: Array[int] = [50, 35, 15]
var weight_total: int = 0
var rand_spawn_chance: int
var inst
var group_size: int = 2

func _ready() -> void:
	level = get_tree().get_first_node_in_group("Level")
	spawnpoints = level.get_tree().get_nodes_in_group("Spawn")
	initialize_spawn_timer()
	spawn_enemies()
	handle_next_wave()

func initialize_spawn_timer() -> void:
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.wait_time = spawnrate
	spawn_timer.one_shot = false
	spawn_timer.timeout.connect(spawn_enemies)

func handle_next_wave() -> void:
	spawn_count = 0
	spawn_timer.start()

func handle_enemy_death() -> void:
	spawnrate = clamp(spawnrate - 0.001 , 0.25, 15.0) 
	handle_next_wave()

func spawn_enemies():
	var random_spawn: Node2D = spawnpoints[randi_range(0, spawnpoints.size() - 1)]
	weight_total = weighted_spawn[0]+weighted_spawn[1]+weighted_spawn[2]
	
	for i in range(0, group_size):
		rand_spawn_chance = randi_range(0, weight_total - 1)
		if i != group_size:
			if rand_spawn_chance > weighted_spawn[0]:
				inst = enemy_striker.instantiate()
			elif rand_spawn_chance > weighted_spawn[1]:
				inst = enemy_dasher.instantiate()
			elif rand_spawn_chance > weighted_spawn[2]:
				inst = enemy_warper.instantiate()
			
			if inst == null:
				pass
			elif inst != null:
				level.add_child(inst)
				inst.global_position = random_spawn.global_position
				spawn_count += 1
			
			if spawn_count == 250:
				spawn_timer.stop()
