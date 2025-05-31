extends Node2D
class_name GreenSlime

const SPEED = 60

var direction := -1

@export var damage_amount: int = 1
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $Hitbox
@onready var ray_cast_down: RayCast2D = $RayCastDown

var GROUND_CHECK_OFFSET := false              # almacena si había suelo delante en el último frame

func _ready() -> void:
	add_to_group("enemies")
	hitbox.body_entered.connect(_on_hitbox_body_entered)
	#Suelo que tiene delante
	GROUND_CHECK_OFFSET = ray_cast_down.is_colliding()

func _physics_process(delta: float) -> void:
	#Pared/obstáculo
	if direction ==  1 and ray_cast_right.is_colliding():
		_turn_left()
	elif direction == -1 and ray_cast_left.is_colliding():
		_turn_right()

	#Comprobación de suelo
	var ground_ahead = ray_cast_down.is_colliding()
	if GROUND_CHECK_OFFSET and not ground_ahead:
		direction *= -1
		animated_sprite.flip_h = (direction == 1)
	# actualizamos el estado para el siguiente frame
	GROUND_CHECK_OFFSET = ground_ahead

	#Movimiento final (una sola vez)
	position.x += direction * SPEED * delta

func _turn_left() -> void:
	direction = -1
	animated_sprite.flip_h = false

func _turn_right() -> void:
	direction = 1
	animated_sprite.flip_h = true

func _on_hitbox_body_entered(body):
	if body is Player:
		if body.velocity.y > 0:
			if body.can_kill_enemies:
				die()
			else:
				body.take_damage(damage_amount)
			body.velocity.y = body.JUMP_VELOCITY * 0.7
		else:
			body.take_damage(damage_amount)

func die() -> void:
	animated_sprite.play()
	set_process(false)
	set_physics_process(false)
	set_deferred("monitoring", false)
	if has_node("CollisionShape2D"):
		$CollisionShape2D.set_deferred("disabled", true)

	var depth_distance: float = 20.0
	var duration: float = 0.3

	var tw = create_tween()
	tw.tween_property(self, "position:y", position.y + depth_distance, duration) \
	  .set_trans(Tween.TRANS_SINE) \
	  .set_ease(Tween.EASE_IN)
	tw.tween_callback(Callable(self, "queue_free"))


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Fireball:
		die()
