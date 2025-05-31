extends Sprite2D

@onready var area_2d: Area2D = $Area2D
@export var damage_amount: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(damage_amount)
