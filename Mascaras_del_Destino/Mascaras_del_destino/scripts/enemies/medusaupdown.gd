extends Node2D

@export var damage_amount : int = 1
@export var total_life : int = 1
@onready var medusaanimatedsprite: AnimatedSprite2D = $medusaanimatedsprite
@onready var medusiahitbox: CollisionShape2D = $medusaarea/medusiahitbox

@export var updown : bool = true
@export var direction: int = -1
@export var speed: float
@export var maxdown: float
@export var maxup: float
@onready var plop: AudioStreamPlayer2D = $plop


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	
	position.y += direction * speed * delta

	if position.y >= maxdown:
		position.y = maxdown
		medusaanimatedsprite.flip_v = false
		direction = -1

	elif position.y <= maxup:
		direction = maxup
		medusaanimatedsprite.flip_v = true
		direction = 1

func _on_hitbox_body_entered(player: Player):
		if player.velocity.y > 0:
			if player.can_kill_enemies:
				die()
			else:
				player.take_damage(damage_amount)
			player.velocity.y = player.JUMP_VELOCITY * 1.0
		else:
			player.take_damage(damage_amount)
			
func die():
	plop.play()
	medusiahitbox.set_deferred("disabled", true)
	medusaanimatedsprite.play("Die")
	await(medusaanimatedsprite.animation_finished)
	queue_free()
