extends CharacterBody2D
class_name Player

const SPEED := 130.0
const JUMP_VELOCITY := -250.0
const walljump_pushback := 20
@onready var game_control: Node = %GameControl

# — Nodos de sonido —
@onready var jump_sound:   AudioStreamPlayer2D = $JumpSound
@onready var damage_sound: AudioStreamPlayer2D = $DamageSound
@onready var die_sound: AudioStreamPlayer2D = $DieSound

# Movimiento, máscaras y estado
var current_mask: Mask = null
var previous_pickup: MaskPickup = null

# Rebote máscara
var mask_bounce_speed := 8.0
var mask_bounce_amplitude := 0.8
var mask_bounce_timer := 0.0

# Vida y físicas
var lives := 2
var max_health := 3
var health := 3
var last_safe_position: Vector2
var fall_limit := 800
var invulnerable := false
var can_kill_enemies: bool = false
var isdead = false

# Sprites y UI
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var mask_sprite: Sprite2D = $MaskSprite
@onready var invulnerability_timer: Timer = $InvulnerabiltyTimer
var hearts: Array[TextureRect] = []

func _ready() -> void:
	add_to_group("player")
	lives = Globalscript.lives
	
	for child in $"../../GUI/UI/containerhearts".get_children():
		if child is TextureRect:
			hearts.append(child)
	update_health_ui()
	
	if Globalscript.checkpoint_set == true:
		position = Globalscript.checkpoint_position
	
	Globalscript.current_level_path()

func _physics_process(delta: float) -> void:
	
	# Efecto máscara
	if current_mask:
		current_mask.apply_effect(self, delta)

	# Gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump_sound.play()
		
		velocity.y = JUMP_VELOCITY - get_platform_velocity().y
		
	if Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4

	# Movimiento horizontal
	var dir := Input.get_axis("ui_left", "ui_right")
	if dir > 0:
		animated_sprite.flip_h = false
		mask_sprite.flip_h = false
		velocity.x = dir * SPEED
	elif dir < 0:
		animated_sprite.flip_h = true
		mask_sprite.flip_h = true
		velocity.x = dir * SPEED
	else:
		# desacelerar al parar
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Animaciones
	if isdead == true:
		animated_sprite.play("Dissapear")
		return
	if dir == 0:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Run")

	move_and_slide()

	# Rebote máscara
	mask_bounce_timer += delta * mask_bounce_speed
	var bounce := sin(mask_bounce_timer) * mask_bounce_amplitude
	var bounce_x := 5
	if mask_sprite.flip_h:
		bounce_x = -3
	else:
		bounce_x = 5
	mask_sprite.position = Vector2(bounce_x, -3 + bounce)

	# Guardar posición segura
	if is_on_floor():
		last_safe_position = position
		
	# Caída al vacío
	if position.y > fall_limit:
		respawn()

	# Parpadeo invulnerable
	if invulnerable:
		#var blink := int(Time.get_ticks_msec() / 100) % 2
		var blink := (Time.get_ticks_msec() >> 7) & 1
		animated_sprite.modulate.a = blink
		mask_sprite.modulate.a = blink
	else:
		animated_sprite.modulate.a = 1
		mask_sprite.modulate.a = 1

func equip_mask(new_mask: Mask, pickup_node: MaskPickup) -> void:
	if new_mask == null:
		mask_sprite.texture = null
		push_warning("equip_mask recibió máscara nula")
		return
		

	# Devolver la máscara anterior
	if previous_pickup:
		previous_pickup.respawn()
		if current_mask and current_mask.has_method("on_unequip"):
			current_mask.on_unequip(self)

	# Desactivar la nueva pickup
	pickup_node.disable()
	previous_pickup = pickup_node

	# Equipar nueva máscara
	current_mask = new_mask
	
	if new_mask is Nomask:
		mask_sprite.texture = new_mask.texture
		can_kill_enemies = new_mask.allows_kill_enemies
		if current_mask.has_method("on_equip"):
			current_mask.on_equip(self)
		current_mask = null
	
	
	if new_mask is not Nomask:
		mask_sprite.texture = new_mask.texture
		can_kill_enemies = new_mask.allows_kill_enemies
		if current_mask.has_method("on_equip"):
			current_mask.on_equip(self)
	
	game_control.itspure(current_mask)	

func update_health_ui() -> void:
	for i in range(hearts.size()):
		hearts[i].visible = i < health
	if health == 1:
		hearts[0].get_child(0).play("beating")
	if health > 1:
		hearts[0].get_child(0).play("idle")

func take_damage(amount: int = 1, grant_invulnerability: bool = true) -> void:
	if isdead or invulnerable:
		return
	
	damage_sound.play()
	health = clamp(health - amount, 0, max_health)
	update_health_ui()
	
	if health <= 0:
		isdead = true
		die()
		return
	
	if grant_invulnerability:
		invulnerable = true
		invulnerability_timer.start()

func heal(amount: int = 1) -> void:
	#Curación, nunca sera menor que cero ni mayor a max health == 3
	health = clamp(health + amount, 0, max_health)
	update_health_ui()

#Cuando te quedas sin corazones, muerte
func die() -> void:
	if Globalscript.lives > 0:
		Globalscript.lives = Globalscript.lives -1 
		lives = Globalscript.lives
		Globalscript.score = 0
	
	if Globalscript.lives <= 0:
		nocontinues()
		return
	
	
	print(Globalscript.lives)
	#Engine.time_scale = 0.5
	die_sound.play()
	await animated_sprite.animation_finished
	#await get_tree().create_timer(0.5).timeout
	#Globalscript.resetscore()
	Engine.time_scale = 1
	get_tree().call_deferred("reload_current_scene")
	
#Cuando te quedas sin vidas
func nocontinues():
	die_sound.play()
	await animated_sprite.animation_finished
	get_tree().call_deferred("change_scene_to_file", "res://scenes/levels/game_over_screen.tscn")

func respawn() -> void:
	take_damage(1, false)
	if health > 0:
		position = last_safe_position
		velocity = Vector2.ZERO


func _on_invulnerabilty_timer_timeout() -> void:
	invulnerable = false
	
func add_lives():
	lives = lives + 1
	Globalscript.lives = lives
	
