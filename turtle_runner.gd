extends Control

@onready var hi_score_label := $CanvasLayer/MarginContainer/HBoxContainer/MarginContainer/HiScore
@onready var current_score_label := $CanvasLayer/MarginContainer/HBoxContainer/CurrentScore
@onready var title := $VBoxContainer/Label
@onready var play_button := $VBoxContainer/PlayButton
@onready var turtle := $Turtle
@onready var turtle_cactus_detector := $Turtle/CactusDetector
@onready var spawner := $Spawner
@onready var animation_player := $AnimationPlayer
@onready var cloud_animation_player := $CloudAnimationPlayer
@onready var cloud_2_animation_player := $Cloud2AnimationPlayer

var hi_score := 0.0
var current_score := 0.0

 
func _ready():
	#start()
	set_process(false)
	turtle_cactus_detector.area_entered.connect(game_over)


func _process(delta):
	current_score += delta
	var tenth_place_score = current_score * 10
	tenth_place_score = floor(tenth_place_score)
	current_score_label.text = "%05d" % [tenth_place_score]
	
	if hi_score < tenth_place_score:
		hi_score = tenth_place_score
		hi_score_label.text = "HI  %05d" % [hi_score]


func start() -> void:
	set_process(true)
	current_score = 0.0
	spawner.start()
	turtle.start()
	play_all_animations()
	
	
func game_over(_node:Node) -> void:
	set_process(false)
	spawner.stop()
	turtle.stop()
	pause_all_animations()
	title.visible = true
	title.text = "Game Over"
	play_button.visible = true
	

func play_all_animations() -> void:
	animation_player.play("ground_moving")
	cloud_animation_player.play("cloud_moving")
	cloud_2_animation_player.play("cloud_2_moving")


func pause_all_animations() -> void:
	animation_player.pause()
	cloud_animation_player.pause()
	cloud_2_animation_player.pause()


func _on_play_button_pressed():
	start()
	title.visible = false
	play_button.visible = false
