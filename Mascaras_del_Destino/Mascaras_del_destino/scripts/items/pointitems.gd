extends Node2D

@export var points: int
@onready var animatedspriteitem: AnimatedSprite2D = $animatedspriteitem
@onready var itemsound: AudioStreamPlayer2D = $itemsound
@onready var collisionitem: CollisionShape2D = $areaitem/collisionitem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func pickedup(body: Node2D):
	if body is Player:
		collisionitem.set_deferred("disabled", true)
		Globalscript.addscore(points)
		animatedspriteitem.play("picked")
		itemsound.play()
		await animatedspriteitem.animation_finished
		queue_free()
	
