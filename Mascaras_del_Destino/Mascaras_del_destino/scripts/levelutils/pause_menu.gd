extends Control

@onready var pause_control: Control = $"."
@onready var resume_button: Button = $VBoxContainer/ResumeButton
@onready var options_panel: Panel = $OptionsPanel
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var panel_container: PanelContainer = $PanelContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	options_panel.visible = false
	pause_control.visible = false	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pause_menu()

func pause_menu():
	if Input.is_action_just_pressed("ui_pause") and get_tree().paused == false:
		pause()
		print("has pulsado escape")
		pause_control.visible = true
		$VBoxContainer/ResumeButton.grab_focus()
		
	elif Input.is_action_just_pressed("ui_pause") and get_tree().paused == true and options_panel.visible == false:
		_on_resume_button_pressed()
		pause_control.visible = false
	
	elif Input.is_action_just_pressed("ui_pause") and get_tree().paused == true and options_panel.visible == true:
		print("salgo pero no")
		$VBoxContainer/ResumeButton.grab_focus()
		pause_control.visible = true
		options_panel.visible = false
		panel_container.visible = true
		v_box_container.visible = true
		
func pause():
	get_tree().paused = true

func _on_resume_button_pressed():
	get_tree().paused = false
	pause_control.visible = false
	options_panel.visible = false
	panel_container.visible = true
	v_box_container.visible = true

func _on_exit_button_pressed() -> void:
	get_tree().quit()
	
func _on_options_button_pressed() -> void:
	panel_container.visible = false
	v_box_container.visible = false
	options_panel.visible = true
	$OptionsPanel/ExitButtonOptions.grab_focus()

func _on_exit_button_options_pressed() -> void:
	$VBoxContainer/ResumeButton.grab_focus()
	pause_control.visible = true
	options_panel.visible = false
	panel_container.visible = true
	v_box_container.visible = true

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/levels/titlescreen.tscn")
