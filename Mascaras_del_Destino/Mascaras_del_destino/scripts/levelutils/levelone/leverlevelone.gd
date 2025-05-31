extends Node2D
@onready var area_2_dlever: Area2D = $area2dlever
@onready var animatedspritelever: AnimatedSprite2D = $animatedspritelever
@onready var game_control: Node = %GameControl
@onready var leversound: AudioStreamPlayer2D = $area2dlever/leversound

var activated : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animatedspritelever.play("notaction")


func _on_area_2_dlever_body_entered(_player: Player) -> void:
	if activated == false:
		activated = true
		leversound.play()
		animatedspritelever.play("actioned")
		game_control.leveractioned()
	else:
		return
