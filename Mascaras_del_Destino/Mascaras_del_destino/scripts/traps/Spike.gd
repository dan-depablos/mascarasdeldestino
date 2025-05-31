extends Area2D
class_name Spike

@export var damage_amount: int = 1
@export var bounce_factor: float = 1.1

func _ready() -> void:
	monitoring = true
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body is Player:
		#Infligir siempre el daño
		body.take_damage(damage_amount)

		#Rebotar solo si este pincho NO está rotado (0°)
		if is_equal_approx(rotation_degrees, 0.0):
			body.velocity.y = body.JUMP_VELOCITY * bounce_factor
