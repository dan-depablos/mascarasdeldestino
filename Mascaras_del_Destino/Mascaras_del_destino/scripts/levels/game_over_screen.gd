extends Control
@onready var si: Button = $ContinueChoiceContainer/SI
@onready var no: Button = $ContinueChoiceContainer/NO
@onready var all_container: VBoxContainer = $AllContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ContinueChoiceContainer/SI.grab_focus()

#Reset global script new game
	Globalscript.resetlevelone()
	Globalscript.resetleveltwo()
	Globalscript.lives = 2
	Globalscript.score = 0

func _on_si_pressed() -> void:
	get_tree().change_scene_to_file(Globalscript.reload_current_level)


func _on_no_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/titlescreen.tscn")
