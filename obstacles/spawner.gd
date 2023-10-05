extends Node2D

var obstacles := [
	preload("cactus_short.tscn"),
	preload("cactus_short_double.tscn"),
	preload("cactus_short_triple.tscn"),
	preload("cactus_tall.tscn"),
	preload("cactus_tall_double.tscn"),
	preload("cactus_tall_triple.tscn"),
	preload("petrie.tscn")
]
var min_seperation := 0.5
var max_seperation := 3.0
var petrie_is_flying := false

@onready var timer := $Timer


func _ready():
	timer.timeout.connect(_on_timer_timeout)
	
func _add_cactus(index : int) -> void:
	add_child(obstacles[index].instantiate())

func _add_petrie(index : int) -> void:
	var petrie_instance = obstacles[index].instantiate()
	petrie_instance.tree_exiting.connect(change_petrie_is_flying_state)
	add_child(petrie_instance)
	change_petrie_is_flying_state()

func start() -> void:
	timer.wait_time = randf_range(min_seperation, max_seperation)
	timer.start()
	if self.get_child_count() != 0:
		for obstacle in self.get_children():
			if obstacle is Timer:
				continue
			obstacle.queue_free()
	
func stop() -> void:
	timer.stop()
	for obstacle in self.get_children():
		obstacle.set_physics_process(false)
		
		
func _on_timer_timeout() -> void:
	if not petrie_is_flying:
		var index := randi_range(0, obstacles.size() - 1)
		timer.wait_time = randf_range(min_seperation, max_seperation)
		if index == obstacles.size() - 1:
			_add_petrie(index)
		else:
			_add_cactus(index)

func change_petrie_is_flying_state() -> void:
	if petrie_is_flying:
		petrie_is_flying = false
	else:
		petrie_is_flying = true

