# Projectile.gd
extends Area2D

@export var speed: float    = 350.0
@export var damage: int     = 1
@export var lifetime: float = 3.0  # segundos antes de autodestruirse

var velocity: Vector2 = Vector2.ZERO * 50

func _ready() -> void:
	# Asegura que puedes detectar cuerpos
	monitoring    = true
	monitorable   = true
	connect("body_entered", Callable(self, "_on_body_entered"))

	# Timer para destrucción tras lifetime segundos
	var t = Timer.new()
	t.one_shot = true
	t.wait_time = lifetime
	add_child(t)
	t.timeout.connect(Callable(self, "queue_free"))
	t.start()

func _physics_process(delta: float) -> void:
	position += velocity * delta

func _on_body_entered(body: Node) -> void:
	if body is Player:
		body.take_damage(damage)
		queue_free()
	else: 
		queue_free()
