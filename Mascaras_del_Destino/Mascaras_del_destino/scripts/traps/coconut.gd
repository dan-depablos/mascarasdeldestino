extends Area2D
class_name Coconut

# — Exportados —
@export var drop_speed:       float = 200.0   # velocidad inicial al caer
@export var bounce_speed:     float = 100.0   # velocidad vertical al rebotar
@export var bounce_horizontal: float = 50.0  # velocidad horizontal al rebotar
@export var ray_length:       float = 200.0   # largo del raycast
@export var damage_amount:    int   = 1      # daño al jugador

# — Estado interno —
var state: int = 0               # 0 = esperando, 1 = cayendo hacia jugador, 2 = parábola tras rebote
var velocity: Vector2 = Vector2.ZERO

@onready var ray: RayCast2D = $RayCast2D

func _ready() -> void:
	# Preparamos el RayCast2D para detectar primero al jugador
	ray.target_position = Vector2(0, ray_length)
	ray.enabled         = true
	ray.collision_mask  = 1 << 1   # capa 2 = jugador
	# Conectamos la señal de rebote
	connect("body_entered", Callable(self, "_on_body_entered"))

func _physics_process(delta: float) -> void:
	match state:
		0:
			#Ver jugador bajo el coco
			if ray.is_colliding() and ray.get_collider() is Player:
				state    = 1
				ray.enabled = false
				velocity = Vector2(0, drop_speed)
				# Activamos la detección de cuerpo para el rebote
				set_deferred("monitoring", true)
		1:
			#Caída vertical hacia el jugador
			velocity.y += gravity * delta
			position   += velocity * delta
		2:
			#Rebote
			velocity.y += gravity * delta
			position   += velocity * delta

			# Una vez que el ray detecte el suelo, desaparecemos
			if not ray.enabled:
				ray.collision_mask = 1 << 0  # capa 1 = suelo
				ray.enabled        = true
			elif ray.is_colliding():
				queue_free()

func _on_body_entered(body: Node) -> void:
	if state == 1 and body is Player and velocity.y > 0:
		# Daño al jugador
		body.take_damage(damage_amount)
		# Parábola: horizontal según posición relativa
		var dir_x := 1 if body.global_position.x < global_position.x else -1
		velocity = Vector2(dir_x * bounce_horizontal, -bounce_speed)
		state    = 2
		# Desactiva colisiones para no chocar más
		set_deferred("monitoring", false)
		set_deferred("collision_layer", 0)
		set_deferred("collision_mask", 0)
		# Preparamos el ray para suelo en el siguiente tick
		ray.set_deferred("enabled", false)
