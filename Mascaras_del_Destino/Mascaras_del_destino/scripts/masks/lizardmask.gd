extends Mask
class_name lizardmask

var same_wall_time := 0.0
const MAX_SAME_WALL_TIME := 0.5
var last_wall_dir := 0
var can_wall_jump := true

func apply_effect(player: Player, delta: float) -> void:
	if player.is_on_floor():
		can_wall_jump = true
		last_wall_dir = 0
		same_wall_time = 0.0

	elif player.is_on_wall():
		var wall_dir := 0
		if player.get_wall_normal() > Vector2(0, 0):
			wall_dir = 1
		elif player.get_wall_normal() < Vector2(0, 0):
			wall_dir = -1

		player.velocity = Vector2(0, min(player.velocity.y, 4.0))

		# Si cambia de pared, reinicia el tiempo
		if wall_dir != last_wall_dir:
			same_wall_time = 0.0
			can_wall_jump = true
			last_wall_dir = wall_dir
		else:
			same_wall_time += delta
			if same_wall_time > MAX_SAME_WALL_TIME:
				can_wall_jump = false

		if Input.is_action_just_pressed("ui_accept") and can_wall_jump:
			if wall_dir == 1 and Input.is_action_pressed("ui_left"):
				player.velocity = Vector2(-player.SPEED, player.JUMP_VELOCITY)
			elif wall_dir == -1 and Input.is_action_pressed("ui_right"):
				player.velocity = Vector2(player.SPEED, player.JUMP_VELOCITY)
