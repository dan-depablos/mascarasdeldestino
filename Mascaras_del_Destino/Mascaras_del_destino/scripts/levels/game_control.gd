extends Node


#VARIABLES Y FUNCIONES GENERALES TODOS LOS NIVELES
var pure: bool = true
var level_name : String

func _ready() -> void:
	level_name = get_tree().current_scene.scene_file_path.get_file()

func itspure(hasmask: Mask):
	if hasmask == null:
		pure = true
	else:
		pure = false

func open_nextlevel_door():
	if pure == true:
		return 1
	else:
		return 0
	
func get_current_level():
	return level_name
	
	
######################################################

#VARIABLES Y FUNCIONES NIVEL UNO
var leveractioned1 = false

func leveractioned():
	leveractioned1 = true

func activateplatform1():
	if leveractioned1 == true:
		return 1
	else:
		return 0

######################################################
