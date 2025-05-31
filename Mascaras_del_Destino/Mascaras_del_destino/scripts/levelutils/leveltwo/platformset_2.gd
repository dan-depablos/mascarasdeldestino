extends Node2D

var dissapear_time = 1

####Platform 1######
@onready var platform_1: StaticBody2D = $Platform1
@onready var area_collision_platform_1_shape: CollisionShape2D = $Platform1/AreaCollisionPlatform1/AreaCollisionPlatform1Shape
@onready var timer_platform_1: Timer = $Platform1/AreaCollisionPlatform1/TimerPlatform1

####Platform 2######
@onready var platform_2: StaticBody2D = $Platform2
@onready var area_collision_platform_2: Area2D = $Platform2/AreaCollisionPlatform2
@onready var timer_platform_2: Timer = $Platform2/AreaCollisionPlatform2/TimerPlatform2

####Platform 3######
@onready var platform_3: StaticBody2D = $Platform3
@onready var area_collision_platform_3: Area2D = $Platform3/AreaCollisionPlatform3
@onready var timer_platform_3: Timer = $Platform3/AreaCollisionPlatform3/TimerPlatform3

####Platform 4######
@onready var platform_4: StaticBody2D = $Platform4
@onready var area_collision_platform_4: Area2D = $Platform4/AreaCollisionPlatform4
@onready var timer_platform_4: Timer = $Platform4/AreaCollisionPlatform4/TimerPlatform4

####Platform 5######
@onready var platform_5: StaticBody2D = $Platform5
@onready var area_collision_platform_5: Area2D = $Platform5/AreaCollisionPlatform5
@onready var timer_platform_5: Timer = $Platform5/AreaCollisionPlatform5/TimerPlatform5

####Platform 6######
@onready var platform_6: StaticBody2D = $Platform6
@onready var area_collision_platform_6: Area2D = $Platform6/AreaCollisionPlatform6
@onready var timer_platform_6: Timer = $Platform6/AreaCollisionPlatform6/TimerPlatform6

####Platform 7######
@onready var platform_7: StaticBody2D = $Platform7
@onready var area_collision_platform_7: Area2D = $Platform7/AreaCollisionPlatform7
@onready var timer_platform_7: Timer = $Platform7/AreaCollisionPlatform7/TimerPlatform7

####Platform 8######
@onready var platform_8: StaticBody2D = $Platform8
@onready var area_collision_platform_8: Area2D = $Platform8/AreaCollisionPlatform8
@onready var timer_platform_8: Timer = $Platform8/AreaCollisionPlatform8/TimerPlatform8

####Platform 9######
@onready var platform_9: StaticBody2D = $Platform9
@onready var area_collision_platform_9: Area2D = $Platform9/AreaCollisionPlatform9
@onready var timer_platform_9: Timer = $Platform9/AreaCollisionPlatform9/TimerPlatform9

####Platform 10######
@onready var platform_10: StaticBody2D = $Platform10
@onready var area_collision_platform_10: Area2D = $Platform10/AreaCollisionPlatform10
@onready var timer_platform_10: Timer = $Platform10/AreaCollisionPlatform10/TimerPlatform10

####Platform 1 Functions######
func _on_area_collision_platform_1_body_entered(body: Node2D) -> void:
	if body is Player and timer_platform_1.is_stopped():
		timer_platform_1.wait_time = dissapear_time
		timer_platform_1.start()
		
	
func _on_timer_platform_1_timeout() -> void:
	if platform_1.collision_layer == (1 << 0):
		platform_1.hide()
		platform_1.set_collision_layer_value(1,0)
		timer_platform_1.wait_time = 2
		timer_platform_1.start()
		return
	if platform_1.collision_layer != (1 << 0):
		platform_1.set_collision_layer_value(1,1)
		platform_1.visible = true
		
####Platform 2 Functions######

func _on_area_collision_platform_2_body_entered(body: Node2D) -> void:
	if body is Player and timer_platform_2.is_stopped():
		timer_platform_2.wait_time = dissapear_time
		timer_platform_2.start()

func _on_timer_platform_2_timeout() -> void:
	if platform_2.collision_layer == (1 << 0):
		platform_2.hide()
		platform_2.set_collision_layer_value(1,0)
		timer_platform_2.wait_time = 2
		timer_platform_2.start()
		return
	if platform_2.collision_layer != (1 << 0):
		platform_2.set_collision_layer_value(1,1)
		platform_2.visible = true

####Platform 3 Functions######

func _on_area_collision_platform_3_body_entered(body: Node2D) -> void:
	if body is Player and timer_platform_3.is_stopped():
		timer_platform_3.wait_time = dissapear_time
		timer_platform_3.start()

func _on_timer_platform_3_timeout() -> void:
	if platform_3.collision_layer == (1 << 0):
		platform_3.hide()
		platform_3.set_collision_layer_value(1,0)
		timer_platform_3.wait_time = 2
		timer_platform_3.start()
		return
	if platform_3.collision_layer != (1 << 0):
		platform_3.set_collision_layer_value(1,1)
		platform_3.visible = true
		
####Platform 4 Functions######
func _on_area_collision_platform_4_body_entered(body: Node2D) -> void:
	if body is Player and timer_platform_4.is_stopped():
		timer_platform_4.wait_time = dissapear_time
		timer_platform_4.start()


func _on_timer_platform_4_timeout() -> void:
	if platform_4.collision_layer == (1 << 0):
		platform_4.hide()
		platform_4.set_collision_layer_value(1,0)
		timer_platform_4.wait_time = 2
		timer_platform_4.start()
		return
	if platform_4.collision_layer != (1 << 0):
		platform_4.set_collision_layer_value(1,1)
		platform_4.visible = true

####Platform 5 Functions######
func _on_area_collision_platform_5_body_entered(body: Node2D) -> void:
	if body is Player and timer_platform_5.is_stopped():
		timer_platform_5.wait_time = dissapear_time
		timer_platform_5.start()
	
func _on_timer_platform_5_timeout() -> void:
	if platform_5.collision_layer == (1 << 0):
		platform_5.hide()
		platform_5.set_collision_layer_value(1,0)
		timer_platform_5.wait_time = 2
		timer_platform_5.start()
		return
	if platform_5.collision_layer != (1 << 0):
		platform_5.set_collision_layer_value(1,1)
		platform_5.visible = true
	
####Platform 6 Functions######
func _on_area_collision_platform_6_body_entered(body: Node2D) -> void:
	if body is Player and timer_platform_6.is_stopped():
		timer_platform_6.wait_time = dissapear_time
		timer_platform_6.start()
	

func _on_timer_platform_6_timeout() -> void:
	if platform_6.collision_layer == (1 << 0):
		platform_6.hide()
		platform_6.set_collision_layer_value(1,0)
		timer_platform_6.wait_time = 2
		timer_platform_6.start()
		return
	if platform_6.collision_layer != (1 << 0):
		platform_6.set_collision_layer_value(1,1)
		platform_6.visible = true
	
####Platform 7 Functions######
func _on_area_collision_platform_7_body_entered(body: Node2D) -> void:
	if body is Player and timer_platform_7.is_stopped():
		timer_platform_7.wait_time = dissapear_time
		timer_platform_7.start()


func _on_timer_platform_7_timeout() -> void:
	if platform_7.collision_layer == (1 << 0):
		platform_7.hide()
		platform_7.set_collision_layer_value(1,0)
		timer_platform_7.wait_time = 2
		timer_platform_7.start()
		return
	if platform_7.collision_layer != (1 << 0):
		platform_7.set_collision_layer_value(1,1)
		platform_7.visible = true

####Platform 8 Functions######
func _on_area_collision_platform_8_body_entered(body: Node2D) -> void:
	if body is Player and timer_platform_8.is_stopped():
		timer_platform_8.wait_time = dissapear_time
		timer_platform_8.start()


func _on_timer_platform_8_timeout() -> void:
	if platform_8.collision_layer == (1 << 0):
		platform_8.hide()
		platform_8.set_collision_layer_value(1,0)
		timer_platform_8.wait_time = 2
		timer_platform_8.start()
		return
	if platform_8.collision_layer != (1 << 0):
		platform_8.set_collision_layer_value(1,1)
		platform_8.visible = true

####Platform 9 Functions######

func _on_area_collision_platform_9_body_entered(body: Node2D) -> void:
	if body is Player and timer_platform_9.is_stopped():
		timer_platform_9.wait_time = dissapear_time
		timer_platform_9.start()
	

func _on_timer_platform_9_timeout() -> void:
	if platform_9.collision_layer == (1 << 0):
		platform_9.hide()
		platform_9.set_collision_layer_value(1,0)
		timer_platform_9.wait_time = 2
		timer_platform_9.start()
		return
	if platform_9.collision_layer != (1 << 0):
		platform_9.set_collision_layer_value(1,1)
		platform_9.visible = true

####Platform 10 Functions######

func _on_area_collision_platform_10_body_entered(body: Node2D) -> void:
	if body is Player and timer_platform_10.is_stopped():
		timer_platform_10.wait_time = dissapear_time
		timer_platform_10.start()

func _on_timer_platform_10_timeout() -> void:
	if platform_10.collision_layer == (1 << 0):
		platform_10.hide()
		platform_10.set_collision_layer_value(1,0)
		timer_platform_10.wait_time = 2
		timer_platform_10.start()
		return
	if platform_10.collision_layer != (1 << 0):
		platform_10.set_collision_layer_value(1,1)
		platform_10.visible = true
