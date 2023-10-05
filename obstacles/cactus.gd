extends Area2D

var speed := 600.0

func _ready():
	#self.body_entered.connect(_on_body_entered)
	self.area_entered.connect(_on_area_entered)
	
func _physics_process(delta):
	var velocity := Vector2.LEFT * speed
	position += velocity * delta
	
#func _on_body_entered(body : Node2D) -> void:
#	body.on_obstacle_hit()        
	
func _on_area_entered(_area :Area2D) -> void:
	self.queue_free()

