extends Node2D

@onready var area_check_point_animated_sprite: AnimatedSprite2D = $AreaCheckPointAnimatedSprite
@onready var check_point: Node2D = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globalscript.checkpoint_set == true:
		area_check_point_animated_sprite.play("activated")
	else:
		area_check_point_animated_sprite.play("notactivated")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_area_check_point_body_entered(body: Node2D) -> void:
	if body is Player and Globalscript.checkpoint_set == false:
		print(position)
		Globalscript.updaterespawnposition(position)
		area_check_point_animated_sprite.play("activated")
		print(Globalscript.checkpoint_position)
