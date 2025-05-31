extends CharacterBody2D
@onready var ray_cast_2_dright: RayCast2D = $RayCast2Dright
@onready var ray_cast_2d_2_left: RayCast2D = $RayCast2D2left
@onready var golem_animated_sprite: AnimatedSprite2D = $GolemAnimatedSprite
@onready var area_2d_golem_damage: Area2D = $Area2dGolemDamage

@export var damage_amount = 2
@export var SPEED = 50

@export var direction = 1

func _physics_process(delta: float) -> void:
	velocity.x = direction * SPEED
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if ray_cast_2_dright.is_colliding() and direction == 1:
		print("voy a la izquierda")
		direction = -1
		golem_animated_sprite.flip_h = true
	if ray_cast_2d_2_left.is_colliding() and direction == -1:
		print("voy a la derecha")
		direction = 1
		golem_animated_sprite.flip_h = false

	move_and_slide()


func _on_area_2d_golem_damage_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(damage_amount)
