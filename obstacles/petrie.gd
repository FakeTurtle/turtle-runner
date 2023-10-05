extends Area2D

var speed := 500.0

func _ready():
	self.body_entered.connect(_on_body_entered)
	self.area_entered.connect(_on_area_entered)
	_random_position()
	
func _physics_process(delta):
	var velocity := Vector2.LEFT * speed
	position += velocity * delta
	
func _random_position() -> void:
	match(randi() % 3):
		0: position.y -= 45
		1: position.y -= 110
		2: position.y -= 150
	
func _on_body_entered(_body : Node2D) -> void:
	$AnimationPlayer.pause()
	
func _on_area_entered(_area :Area2D) -> void:
	self.queue_free()


