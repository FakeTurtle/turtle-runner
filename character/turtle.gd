extends CharacterBody2D


const JUMP_VELOCITY = -750.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var cactus_detector := $CactusDetector
@onready var animation_player := $AnimationPlayer
@onready var running_1 := $Running1
@onready var running_2 := $Running2
@onready var dead_sprite := $Dead
@onready var jump_audio := $JumpAudio
@onready var death_audio := $CactusDetector/DeathAudio

func _ready():
	#start()
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_audio.play()

	move_and_slide()

func set_dead_sprite() -> void:
	dead_sprite.visible = true
	running_1.visible = false
	running_2.visible = false
	
func start() -> void:
	animation_player.play("running")
	$Default.visible = false
	dead_sprite.visible = false
	set_physics_process(true)
	
func stop() -> void:
	animation_player.stop()
	set_dead_sprite()
	set_physics_process(false)
	death_audio.play()
	
