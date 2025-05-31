extends CharacterBody2D

const SPEED = 60
var direction: int = 0
var attack_range: float = 26.0
var stayingarea: Vector2
var itsplayer: Node2D = null
var damage: int = 2
var is_attacking = false
var life = 3
var isdying = false

@onready var cactoanimatedsprite: AnimatedSprite2D = $catoanimatedsprite
@onready var cactoplayerwatcherarea: Area2D = $cactoplayerwatcherarea
@onready var cactoattackarea: Area2D = $cactoattackarea
@onready var cactoattackbox: CollisionShape2D = $cactoattackarea/cactoattackbox
@onready var hitarea: Area2D = $Hitarea
@onready var attackarms: AudioStreamPlayer2D = $attackarms
@onready var hitsound: AudioStreamPlayer2D = $hitsound
@onready var diesound: AudioStreamPlayer2D = $diesound




func _ready() -> void:
	stayingarea = global_position
	

func _physics_process(delta: float) -> void:
	if isdying:
		return
	if not is_on_floor():
		velocity += get_gravity() * delta
	if itsplayer:
		playerwatch()
	else:
		playerout()

	move_and_slide()

func _on_player_entered(player: Player) -> void:
	itsplayer = player

func _on_player_exited(player: Player) -> void:
	if itsplayer == player:
		itsplayer = null

func playerwatch() -> void:
	if Globalscript.cactobrotwo == false:
		Globalscript.cactobrotwo = true
		
		
	var distance = global_position.distance_to(itsplayer.global_position)

	cactoanimatedsprite.flip_h = itsplayer.global_position.x < global_position.x
	if itsplayer.global_position.x < global_position.x:
		cactoattackbox.position.x = -abs(cactoattackbox.position.x)
	else:
		cactoattackbox.position.x = abs(cactoattackbox.position.x)
		
		
	if distance > attack_range and not is_attacking:
		var dir = (itsplayer.global_position - global_position).normalized()
		direction = sign(dir.x)
		velocity.x = direction * SPEED
		cactoanimatedsprite.play("walk")
	
	if is_attacking == false and distance <= attack_range:
		print("controlo ataque")
		velocity.x = 0
		attack()

func playerout() -> void:
	var dir = (stayingarea - global_position).normalized()
	
	if not is_attacking and not isdying:	
		velocity.x = dir.x * SPEED

		if dir.x > 0:
			direction = 1
		elif dir.x < 0:
			direction = -1
		cactoanimatedsprite.play("walk")

	if global_position.distance_to(stayingarea) < 2.0:
		velocity.x = 0
		cactoanimatedsprite.play("idle")

func attack():
	is_attacking = true
	cactoanimatedsprite.play("attack")
	attackarms.play()
	await get_tree().create_timer(0.45).timeout
	if itsplayer and itsplayer in cactoattackarea.get_overlapping_bodies():
		itsplayer.take_damage(damage)
		
	await cactoanimatedsprite.animation_looped
	is_attacking = false

func _on_hitbox_body_entered(player: Player):
	if isdying:
		return
		
	if player.velocity.y > 0:
		if player.can_kill_enemies:
			life -= 1  # O usa take_damage(1) si tenés una función
			player.velocity.y = player.JUMP_VELOCITY * 0.6
			hitsound.play()
			
			if life <= 0:
				die()
			else:
				isdying = true
				cactoanimatedsprite.play("hit")
				await cactoanimatedsprite.animation_finished
				isdying = false
		else:
			player.take_damage(damage)
	else:
		player.take_damage(damage)
		
func die():
	isdying = true
	diesound.play()
	velocity.x = 0
	cactoanimatedsprite.play("die")
	cactoplayerwatcherarea.set_deferred("monitoring", false)
	cactoattackarea.set_deferred("monitoring", false)
	hitarea.set_deferred("monitoring", false)
	await cactoanimatedsprite.animation_finished
	queue_free()
