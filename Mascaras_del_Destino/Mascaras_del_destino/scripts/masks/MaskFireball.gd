extends Mask
class_name MaskFireball

# ——— Propias de Fireball
@export var fireball_scene: PackedScene
@export var cooldown: float = 0.5

var _timer: float = 0.0

func apply_effect(player: Player, delta: float) -> void:
	_timer = max(_timer - delta, 0)
	if Input.is_action_just_pressed("ui_attack") and _timer == 0:
		_shoot(player)
		_timer = cooldown

func _shoot(player: Player) -> void:
	var ball = fireball_scene.instantiate() as Fireball

	# Dirección
	var dir = Vector2.LEFT if player.animated_sprite.flip_h else Vector2.RIGHT

	# Ajuste posicion bola:
	var offset_x = dir.x * 12    # distancia horizontal desde el centro del jugador
	var offset_y = -4            # movimiento vertical (menos negativo = más abajo)

	ball.global_position = player.global_position + Vector2(offset_x, offset_y)
	ball.velocity = dir * ball.speed

	# Voltea la bola si dispara hacia la izquierda
	if ball.has_node("Sprite"):
		ball.get_node("Sprite").flip_h = dir.x < 0

	player.get_tree().current_scene.add_child(ball)
