extends Area2D
class_name HealthPickup

@export var heal_amount: int = 1
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var HealthSound: AudioStreamPlayer2D = $healthsound

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body is Player:
		HealthSound.play()
		body.heal(heal_amount)
		animated_sprite_2d.visible = false
		disconnect("body_entered", Callable(self, "_on_body_entered"))
		await get_tree().create_timer(2.2).timeout
		queue_free()
