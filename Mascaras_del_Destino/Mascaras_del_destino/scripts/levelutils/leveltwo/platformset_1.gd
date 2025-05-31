extends Node2D

####Platform 1######
@onready var platform_1: AnimatableBody2D = $Platform1
@onready var trigger_platform_1: Area2D = $TriggerPlatform1
@onready var collision_platform_1: CollisionShape2D = $TriggerPlatform1/CollisionPlatform1
@onready var timer_platform_1: Timer = $TriggerPlatform1/TimerPlatform1

####Platform 2######
@onready var platform_2: AnimatableBody2D = $Platform2
@onready var trigger_platform_2: Area2D = $TriggerPlatform2
@onready var collision_platform_2: CollisionShape2D = $TriggerPlatform2/CollisionPlatform2
@onready var timer_platform_2: Timer = $TriggerPlatform2/TimerPlatform2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

#### Func Platform 1 ######
func _on_trigger_platform_1_body_entered(body: Node2D) -> void:
	if body is Player and timer_platform_1.is_stopped():
		timer_platform_1.wait_time = 0.5 
		timer_platform_1.start()
		
func _on_timer_platform_1_timeout() -> void:
	if platform_1.process_mode == Node.PROCESS_MODE_INHERIT:
		platform_1.process_mode = Node.PROCESS_MODE_DISABLED
		platform_1.visible = false
		timer_platform_1.wait_time = 2
		timer_platform_1.start()
		return
	if platform_1.process_mode == Node.PROCESS_MODE_DISABLED:
		platform_1.process_mode = Node.PROCESS_MODE_INHERIT
		platform_1.visible = true
		
#### Func Platform 2 ######
	
func _on_trigger_platform_2_body_entered(body: Node2D) -> void:
	if body is Player and timer_platform_2.is_stopped():
		timer_platform_2.wait_time = 0.5 
		timer_platform_2.start()


func _on_timer_platform_2_timeout() -> void:
	if platform_2.process_mode == Node.PROCESS_MODE_INHERIT:
		platform_2.process_mode = Node.PROCESS_MODE_DISABLED
		platform_2.visible = false
		timer_platform_2.wait_time = 2
		timer_platform_2.start()
		return
	if platform_2.process_mode == Node.PROCESS_MODE_DISABLED:
		platform_2.process_mode = Node.PROCESS_MODE_INHERIT
		platform_2.visible = true
