# MaskPickup.gd
extends Area2D
class_name MaskPickup

@export var mask_resource: Mask

var original_position: Vector2

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var maskpickupsound: AudioStreamPlayer2D = $maskpickupsound


func _ready() -> void:
	original_position = global_position
	_enable()
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body is Player and mask_resource:
		body.equip_mask(mask_resource, self)
		maskpickupsound.play()

func respawn() -> void:
	global_position = original_position
	_enable()

func disable() -> void:
	hide()
	# Cambiamos la propiedad de monitoring de forma diferida
	set_deferred("monitoring", false)
	# Deshabilitamos la colisión de forma diferida
	collision_shape.call_deferred("set_deferred", "disabled", true)

func _enable() -> void:
	show()
	set_deferred("monitoring", true)
	collision_shape.call_deferred("set_deferred", "disabled", false)
	
