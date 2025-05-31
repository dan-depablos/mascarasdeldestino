extends Node2D
@export var up : float
@export var down : float
@export var SPEED : int


@onready var game_control: Node = %GameControl
@onready var node_2d: Node2D = $"."

@onready var collision_shape_2d: CollisionShape2D = $AnimatableBody2D/CollisionShape2D
@onready var animatable_body_2d: AnimatableBody2D = $AnimatableBody2D



var direction = -1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_shape_2d.disabled = true
	visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if game_control.activateplatform1():
	
		visible = true
		collision_shape_2d.disabled = false
		
		animatable_body_2d.position.y += direction * SPEED * delta	 
		if animatable_body_2d.position.y <= up:
			direction = 1
		if animatable_body_2d.position.y >= down:
			direction = -1
