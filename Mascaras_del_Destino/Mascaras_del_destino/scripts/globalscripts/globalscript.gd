extends Node

#Variables puntuacion
var score: int = 0
var highscore: int = 0

#Variables jugador
var lives: int = 2

#Variables niveles pasados
var tutorial_passed = false
var niveluno_passed = false
var niveldos_passed = false

#Variable nivel actual
var reload_current_level : String

########################## Variables y funciones particulares niveles ##############################
#Niveluno
var life_niveluno_uno : bool = true
var cactobroone : bool = true
var cactobrotwo : bool = false

func resetlevelone():
	life_niveluno_uno = true
	cactobroone = true
	cactobrotwo = false


#Niveldos
var checkpoint_position : Vector2 = Vector2.ZERO
var checkpoint_set : bool = false
var life_nivel_dos_uno : bool = true
var life_nivel_dos_dos : bool = true

func resetleveltwo():
	life_nivel_dos_uno = true
	life_nivel_dos_dos = true
	checkpoint_position = Vector2.ZERO
	checkpoint_set = false
	
func updaterespawnposition(checkpoint: Vector2):
	checkpoint_position = checkpoint
	checkpoint_set = true

####################################################################################################

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func addscore(points):
	score = score + points
	#print(score)
	if score > highscore:
		highscore = score
	#	print("El highscore es ",highscore)

func resetscore():	
	score = 0
	
func current_level_path():
	reload_current_level = get_tree().current_scene.scene_file_path
	
## Funcion guardado
func save_state():
	var save_data = {
		"tutorial_passed": tutorial_passed,
		"niveluno_passed": niveluno_passed,
		"niveldos_passed": niveldos_passed
	}
	var file = FileAccess.open("user://savegame.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()
	
func load_state():
	if not FileAccess.file_exists("user://savegame.json"):
		return
	var file = FileAccess.open("user://savegame.json", FileAccess.READ)
	var content = file.get_as_text()
	var save_data = JSON.parse_string(content)
	if typeof(save_data) == TYPE_DICTIONARY:
		print("estoy aqui")
		tutorial_passed = save_data.get("tutorial_passed", false)
		niveluno_passed = save_data.get("niveluno_passed", false)
		niveldos_passed = save_data.get("niveldos_passed", false)
	file.close()
	
