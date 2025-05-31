extends Node2D
@onready var shake: AnimationPlayer = $"../../../Hero & Unique elements/Heroe/Camera2D/Shake"

func _on_shake_enter_area_body_entered(body: Node2D) -> void:
	if body is Player:
		shake.play("shake")
		


func _on_shake_exit_area_body_exited(body: Node2D) -> void:
	if body is Player:
		shake.stop()
		
