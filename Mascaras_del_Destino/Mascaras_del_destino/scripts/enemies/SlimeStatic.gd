extends Node2D
class_name SlimeStatic

const SPEED = 60

var direction := 1

@export var damage_amount: int = 1
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $Hitbox

func _ready():
	add_to_group("enemies")
	hitbox.body_entered.connect(_on_hitbox_body_entered)

func _on_hitbox_body_entered(body):
	if body is Player:
		if body.velocity.y > 0:  # Jugador cayendo
			if body.can_kill_enemies:
				die()
			else:
				body.take_damage(damage_amount)
			
			# Siempre rebota si cae encima
			body.velocity.y = body.JUMP_VELOCITY * 0.7  # Rebote reducido
		else:
			# Golpe lateral o por debajo
			body.take_damage(damage_amount)

func die() -> void:
	# — 0) Detener toda lógica de movimiento y colisiones inmediatamente —
	set_process(false)
	set_physics_process(false)
	set_deferred("monitoring", false)
	if has_node("CollisionShape2D"):
		$CollisionShape2D.set_deferred("disabled", true)

	# — 1) Hundirse en el suelo con un tween —
	var depth_distance: float = 20.0  # píxels hacia abajo
	var duration: float = 0.3         # segundos de hundimiento

	var tw = create_tween()
	tw.tween_property(self, "position:y", position.y + depth_distance, duration) \
	  .set_trans(Tween.TRANS_SINE) \
	  .set_ease(Tween.EASE_IN)

	# — 2) Al terminar, eliminar el nodo —
	tw.tween_callback(Callable(self, "queue_free"))
