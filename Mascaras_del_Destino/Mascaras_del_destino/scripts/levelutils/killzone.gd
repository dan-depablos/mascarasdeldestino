extends Area2D
class_name KillZone

func _on_body_entered(body: Node) -> void:
	if body is Player:
		body.respawn()
