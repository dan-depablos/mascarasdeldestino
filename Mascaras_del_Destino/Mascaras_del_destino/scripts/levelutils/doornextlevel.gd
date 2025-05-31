extends Node2D

@onready var game_control: Node = %GameControl
@onready var door_animation: AnimatedSprite2D = $door_animation
@onready var door_text: RichTextLabel = $door_text

var opened = false
var current_level : String

func _ready() -> void:
	current_level = game_control.get_current_level()
	pass
	
	
func _process(_delta: float) -> void:
	if game_control.open_nextlevel_door() == 0:
		door_animation.play("closed")
		opened = false
	else:
		if door_animation.animation != "opend" and game_control.open_nextlevel_door() == 1:
			door_animation.play("opend")
			opened = true
			await get_tree().create_timer(2).timeout
			door_animation.pause()

func pass_level(_player: Player):
	if opened == false:
		door_text.visible = true
	if opened == true and current_level == "Tutorial.tscn":
		Globalscript.tutorial_passed = true
		Globalscript.save_state()
		get_tree().call_deferred("change_scene_to_file", "res://scenes/levels/niveluno.tscn")
		
	
	if opened == true and current_level == "niveluno.tscn":
		Globalscript.niveluno_passed = true
		Globalscript.save_state()
		get_tree().call_deferred("change_scene_to_file", "res://scenes/levels/niveldos.tscn")
		
	
	if opened == true and current_level == "niveldos.tscn":
		Globalscript.niveldos_passed = true
		Globalscript.save_state()
		get_tree().call_deferred("change_scene_to_file", "res://scenes/levels/titlescreen.tscn")
		
		

func untouch_door(_player: Player):
	door_text.visible = false


func untouched_door(_player: Player) -> void:
	pass # Replace with function body.
