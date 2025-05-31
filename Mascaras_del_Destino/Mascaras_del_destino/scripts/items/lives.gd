extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var game_control: Node = %GameControl

@export var vida_id : int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globalscript.life_niveluno_uno == false and vida_id == 1:
		visible = false
		area_2d.monitoring = false
		collision_shape_2d.disabled = true
	
	if Globalscript.life_nivel_dos_uno == false and vida_id == 2:
		visible = false
		area_2d.monitoring = false
		collision_shape_2d.disabled = true
		
	if Globalscript.life_nivel_dos_dos == false and vida_id == 3:
		visible = false
		area_2d.monitoring = false
		collision_shape_2d.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func extralife(player: Player):
	audio_stream_player_2d.play()
	collision_shape_2d.set_deferred("disabled", true)
	animated_sprite_2d.play("picked")
	await animated_sprite_2d.animation_finished
	player.add_lives()
	queue_free()
	print(position.round())
	
	if vida_id == 1:
		Globalscript.life_niveluno_uno = false
	
	if vida_id == 2:
		Globalscript.life_nivel_dos_uno = false
	
	if vida_id == 3:
		Globalscript.life_nivel_dos_dos = false
