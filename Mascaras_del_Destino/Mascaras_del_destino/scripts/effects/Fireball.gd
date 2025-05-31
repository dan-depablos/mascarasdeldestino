# res://scripts/Fireball.gd
extends Area2D
class_name Fireball

@export var speed: float = 400.0
@export var damage: int = 1
@export var lifetime: float = 1

var velocity: Vector2 = Vector2.ZERO
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var life_timer: Timer = $LifeTimer

func _ready() -> void:
	sprite.play("fly")
	life_timer.start()
	life_timer.timeout.connect(queue_free)

	monitoring = true
	# Conectar ambas señales
	connect("body_entered", Callable(self, "_on_collided"))
	connect("area_entered", Callable(self, "_on_collided"))

func _physics_process(delta: float) -> void:
	position += velocity * delta
	sprite.flip_h = velocity.x < 0  # gira el sprite según la dirección

func _on_collided(collider: Node) -> void:
	# Si es enemigo, dale daño
	if collider.is_in_group("enemies") and collider.has_method("take_damage"):
		collider.take_damage(damage)
	# En cualquier caso (enemigo o muro) destruye la bola
	queue_free()
