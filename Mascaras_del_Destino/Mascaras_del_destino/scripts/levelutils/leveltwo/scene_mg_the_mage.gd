extends Node2D
@onready var mg_the_mage: AnimatedSprite2D = $MgTheMage
@onready var sign_trigger: Area2D = $SignTrigger
@onready var no_mask_appear: MaskPickup = $NoMaskAppear
@onready var no_mask: AnimatedSprite2D = $NoMaskAppear/NoMask
@onready var exit_area_object_appear: Area2D = $ExitAreaObjectAppear
@onready var exit_area_shape: CollisionShape2D = $ExitAreaObjectAppear/ExitAreaShape


func _on_exit_area_object_appear_body_exited(body: Node2D) -> void:
	if body is Player:
		mg_the_mage.play("dissapear")
		no_mask_appear.set_deferred("monitorable", false)
		no_mask_appear.set_deferred("monitoring", false)
		sign_trigger.set_deferred("monitorable", false)
		sign_trigger.set_deferred("monitoring", false)

		if mg_the_mage.animation == "dissapear":
			await(mg_the_mage.animation_finished)
			mg_the_mage.visible = false
			exit_area_shape.disabled = true
		

		no_mask.visible = true
		no_mask.play("appear")
		await(no_mask.animation_finished)
		no_mask.play("object")
		no_mask_appear.set_deferred("monitorable", true)
		no_mask_appear.set_deferred("monitoring", true)
		
		
			
	
	exit_area_object_appear.monitorable = false
	exit_area_object_appear.monitoring = false
