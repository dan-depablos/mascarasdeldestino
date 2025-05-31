extends Node2D

@onready var detection_area: Area2D = $SpikeWallAnimatableBody/DetectionArea
@onready var animation_spike_wall: AnimationPlayer = $SpikeWallAnimatableBody/AnimationSpikeWall



func _on_area_spike_wall_hit_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(3)

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		animation_spike_wall.play("kill")
