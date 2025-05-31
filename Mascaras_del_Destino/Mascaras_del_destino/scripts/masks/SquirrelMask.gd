extends Mask
class_name SquirrelMask

func on_equip(player: Player) -> void:
	# Reducir al 50%
	player.scale = Vector2(0.5, 0.5)
	# Activar muerte por salto
	player.can_kill_enemies = true

func on_unequip(player: Player) -> void:
	# Restaurar tamaño
	player.scale = Vector2(1, 1)
	# Desactivar muerte por salto
	player.can_kill_enemies = false

func apply_effect(_player: Player, _delta: float) -> void:
	# No hace nada en cada frame
	pass
