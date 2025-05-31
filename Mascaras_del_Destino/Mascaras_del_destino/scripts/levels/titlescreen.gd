extends Control

#Containers
@onready var main_buttons_container: VBoxContainer = $MainButtonsContainer
@onready var options_panel: Panel = $OptionsPanel
@onready var new_game_or_select_level: VBoxContainer = $NewGameOrSelectLevel
@onready var la_playa: VBoxContainer = $LaPlaya

#Buttons
@onready var level_selector: Button = $NewGameOrSelectLevel/LevelSelector
@onready var nivel_uno: Button = $LaPlaya/NivelUno
@onready var nivel_dos: Button = $LaPlaya/NivelDos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Cargar estado globalscript niveles
	Globalscript.load_state()
	
	$MainButtonsContainer/PlayButton.grab_focus()
	main_buttons_container.visible = true
	options_panel.visible = false
	new_game_or_select_level.visible = false
	la_playa.visible = false
	
	#Seleccion de nivel deshabilitada por defecto
	nivel_uno.visible = false
	nivel_dos.visible = false
	
	#Deshabilitar seleccion de nivel si no se ha pasado el tutorial
	if Globalscript.tutorial_passed == false:
		level_selector.disabled = true
		level_selector.focus_mode = Control.FOCUS_NONE
	
	if Globalscript.tutorial_passed == true:
		level_selector.disabled = false
		level_selector.focus_mode = Control.FOCUS_ALL
		nivel_uno.visible = true
	
	if Globalscript.niveluno_passed == true:
		nivel_dos.visible = true
	
		
	#Reset global script new game
	Globalscript.resetlevelone()
	Globalscript.resetleveltwo()
	Globalscript.lives = 2
	Globalscript.score = 0
	Globalscript.reload_current_level = "res://scenes/levels/titlescreen.tscn"
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

############################ Main Buttons Container Functions ######################################
func _on_play_button_pressed() -> void:
	$NewGameOrSelectLevel/NewGame.grab_focus()
	new_game_or_select_level.visible = true
	main_buttons_container.visible = false
	
	

func _on_options_button_pressed() -> void:
	$OptionsPanel/MusicSound.grab_focus()
	print("opciones presionado")
	main_buttons_container.visible = false
	options_panel.visible = true
	

func _on_exit_button_pressed() -> void:
	get_tree().quit()
	
####################################################################################################


######################### New Game or select level Container Functions #############################
func _on_return_new_game_or_select_level_pressed() -> void:
	$MainButtonsContainer/PlayButton.grab_focus()
	main_buttons_container.visible = true
	new_game_or_select_level.visible = false
	
func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/Tutorial.tscn")

func _on_level_selector_pressed() -> void:
	new_game_or_select_level.visible = false
	la_playa.visible = true
	$LaPlaya/Tutorial.grab_focus()
####################################################################################################


####################### Level Select (La Playa) Container Functions ################################
func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/Tutorial.tscn")

func _on_nivel_uno_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/niveluno.tscn")

func _on_nivel_dos_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/niveldos.tscn")

func _on_return_la_playa_pressed() -> void:
	la_playa.visible = false
	new_game_or_select_level.visible = true
	$NewGameOrSelectLevel/NewGame.grab_focus()
####################################################################################################



################################# Options Container Functions ######################################
func _on_exit_button_options_pressed() -> void:
	$MainButtonsContainer/PlayButton.grab_focus()
	print("boton salida opciones presionado")
	main_buttons_container.visible = true
	options_panel.visible = false

####################################################################################################
