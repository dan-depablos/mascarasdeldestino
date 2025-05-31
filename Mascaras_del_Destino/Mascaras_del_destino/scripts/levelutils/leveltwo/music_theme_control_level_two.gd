extends Node2D

@onready var beach_theme: AudioStreamPlayer = $BeachTheme
@onready var labyrinth_theme: AudioStreamPlayer = $LabyrinthTheme
@onready var ray_cast_exit_right: RayCast2D = $EnterCaveArea/RayCastExitRight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_enter_cave_area_body_exited(body: Node2D) -> void:
	if body is Player and beach_theme.playing == false and not ray_cast_exit_right.is_colliding():
		labyrinth_theme.stop()
		beach_theme.play()
		return
	if body is Player and beach_theme.playing == true and ray_cast_exit_right.is_colliding():
		beach_theme.stop()
		labyrinth_theme.play()
		return

func _on_exit_cave_area_body_exited(body: Node2D) -> void:
	if body is Player and beach_theme.playing == false:
		labyrinth_theme.stop()
		beach_theme.play()
		return
	if body is Player and beach_theme.playing == true:
		beach_theme.stop()
		labyrinth_theme.play()
		return


func _on_respawn_music_labyrinth_body_entered(_body: Node2D) -> void:
	if labyrinth_theme.playing == false:
		beach_theme.stop()
		labyrinth_theme.play()
