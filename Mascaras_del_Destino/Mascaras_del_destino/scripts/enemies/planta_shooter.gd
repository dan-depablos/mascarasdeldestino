extends Area2D
class_name PlantaShooter

# ——— Stats de combate y proyectiles ———
@export var damage_amount: int = 1
@export var projectile_scene: PackedScene
@export var projectile_speed: float = 125.0

# ——— Vida ———
@export var max_health:     int = 2
var health:                 int

# ——— Nodos hijos ———
@onready var sprite:      AnimatedSprite2D = $AnimatedSprite2D
@onready var muzzle:      Marker2D         = $AnimatedSprite2D/Muzzle
@onready var vision_area: Area2D           = $VisionArea
@onready var projectileplantaudio: AudioStreamPlayer2D = $projectileplantaudio
@onready var planthitaudio: AudioStreamPlayer2D = $planthitaudio

# ——— IA interna ———
var player_in_sight: bool = false
var target_player:  Player = null

func _ready() -> void:
	# Grupo para que Fireball también nos detecte
	add_to_group("enemies")

	# Inicializar vida
	health = max_health

	# Conexiones IA
	sprite.play("idle")
	vision_area.body_entered.connect(_on_vision_body_entered)
	vision_area.body_exited.connect(_on_vision_body_exited)
	sprite.frame_changed.connect(_on_frame_changed)

	# Detectar colisiones con el jugador (salto) y con Fireball (área)
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("area_entered", Callable(self, "_on_area_entered"))

func _process(_delta: float) -> void:
	if player_in_sight and is_instance_valid(target_player):
		_aim_at_player()

func _aim_at_player() -> void:
	sprite.flip_h = target_player.global_position.x > global_position.x

func _on_vision_body_entered(body: Node) -> void:
	if body is Player:
		player_in_sight = true
		target_player   = body
		sprite.play("shoot")

func _on_vision_body_exited(body: Node) -> void:
	if body == target_player:
		player_in_sight = false
		target_player   = null
		sprite.play("idle")

func _on_frame_changed() -> void:
	# Dispara cuando toca el fotograma 4 de “shoot”
	if player_in_sight \
	and sprite.animation == "shoot" \
	and sprite.frame == 3:
		_shoot()

func _shoot() -> void:
	var p = projectile_scene.instantiate()
	get_tree().current_scene.add_child(p)
	p.global_position = muzzle.global_position
	var dir = Vector2(target_player.global_position.x - global_position.x, 0).normalized()
	projectileplantaudio.play()
	p.velocity = dir * projectile_speed

# ——— Colisión con el jugador (salto) ———
func _on_body_entered(body: Node) -> void:
	if body is Player and body.velocity.y > 0:
		# Rebote vertical
		body.velocity.y = body.JUMP_VELOCITY * 0.7

		# Si el jugador puede matar enemigos, dañamos a la planta
		if body.can_kill_enemies:
			take_damage(1)
		else:
			# Si no, el jugador recibe daño
			body.take_damage(damage_amount)

# ——— Colisión con Fireball (área) ———
func _on_area_entered(area: Area2D) -> void:
	# Si entra una bola de fuego, le quita 2 puntos
	if area is Fireball:
		take_damage(area.damage)

# ——— Reducir vida y morir ———
func take_damage(amount: int) -> void:
	health -= amount
	planthitaudio.play()
	if health <= 0:
		die()
	else:
		# (Opcional) Feedback de daño
		sprite.modulate = Color(1, 0.5, 0.5)
		await get_tree().create_timer(0.3).timeout
		sprite.modulate = Color(1,1,1)

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
