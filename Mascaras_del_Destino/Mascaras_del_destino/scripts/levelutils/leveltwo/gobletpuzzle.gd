extends Node2D

@onready var gobletleftarea_2d: Area2D = $gobletleftanimatedsprite/gobletleftarea2d
@onready var gobletleftanimatedsprite: AnimatedSprite2D = $gobletleftanimatedsprite

@onready var gobletrightanimatedsprite: AnimatedSprite2D = $gobletrightanimatedsprite
@onready var gobletrightarea_2d: Area2D = $gobletrightanimatedsprite/gobletrightarea2d

@onready var gobletdownanimatedsprite_2: AnimatedSprite2D = $gobletdownanimatedsprite2
@onready var gobletdownarea_2d: Area2D = $gobletdownanimatedsprite2/gobletdownarea2d

@onready var gateanimation: AnimationPlayer = $gate/gateanimation

@onready var completed: AudioStreamPlayer = $Completed
@onready var wrong_combo: AudioStreamPlayer = $WrongCombo
@onready var lit: AudioStreamPlayer = $Lit


#Variables
var firstlit: String
var secondlit: String
var thirdlit: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



####Goblet left####

func _on_gobletleftarea_2d_area_entered(area: Area2D) -> void:
	if area is Fireball:
		if firstlit == "" and gobletleftanimatedsprite.animation != "lit": 
			lit.play()
			firstlit = "gobletleft"
			gobletleftanimatedsprite.play("lit")
			return
		if secondlit == "" and gobletleftanimatedsprite.animation != "lit":
			lit.play()
			secondlit = "gobletleft"
			gobletleftanimatedsprite.play("lit")
			return
		if thirdlit == "" and gobletleftanimatedsprite.animation != "lit":
			lit.play()
			thirdlit = "gobletleft"
			gobletleftanimatedsprite.play("lit")
			check_lit_order()
		
		
####Goblet right####

func _on_gobletrightarea_2d_area_entered(area: Area2D) -> void:
	if area is Fireball:
		if firstlit == "" and gobletrightanimatedsprite.animation != "lit":
			lit.play()
			firstlit = "gobletright"
			gobletrightanimatedsprite.play("lit")
			return
		if secondlit == "" and gobletrightanimatedsprite.animation != "lit":
			lit.play()
			secondlit = "gobletright"
			gobletrightanimatedsprite.play("lit")
			return
		if thirdlit == "" and gobletrightanimatedsprite.animation != "lit":
			lit.play()
			thirdlit = "gobletright"
			gobletrightanimatedsprite.play("lit")
			check_lit_order()


####Goblet down####

func _on_gobletdownarea_2d_area_entered(area: Area2D) -> void:
	if area is Fireball:
		if firstlit == "" and gobletdownanimatedsprite_2.animation != "lit":
			lit.play()
			firstlit = "gobletdown"
			gobletdownanimatedsprite_2.play("lit")
			return
		if secondlit == "" and gobletdownanimatedsprite_2.animation != "lit":
			lit.play()
			secondlit = "gobletdown"
			gobletdownanimatedsprite_2.play("lit")
			return
		if thirdlit == "" and gobletdownanimatedsprite_2.animation != "lit":
			lit.play()
			thirdlit = "gobletdown"
			gobletdownanimatedsprite_2.play("lit")
			check_lit_order()

		


#### Todos encendidos ####
func check_lit_order():
	print("El primero ha sido" + firstlit)
	print("El segundo ha sido" + secondlit)
	print("El tercero ha sido" + thirdlit)
	
	if firstlit == "gobletdown" and secondlit == "gobletleft" and thirdlit == "gobletright":
		completed.play()
		gateanimation.play("opened")
	else:
		wrong_combo.play()
		gobletdownanimatedsprite_2.play("unlit")
		gobletrightanimatedsprite.play("unlit")
		gobletleftanimatedsprite.play("unlit")
		firstlit=""
		secondlit=""
		thirdlit=""
