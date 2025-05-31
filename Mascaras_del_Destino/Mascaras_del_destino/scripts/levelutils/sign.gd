extends Area2D

@export var popup_text: String = "Pulsa [E] para interactuar"
@export var player_group: String = "player"   
@onready var label := $RichTextLabel            
@onready var richtextlabel: RichTextLabel = $RichTextLabel
@onready var audiotext: AudioStreamPlayer2D = $audiotext



func _ready() -> void:
	richtextlabel.text = popup_text
	label.visible = false
	body_entered.connect(_on_body_entered)    
	body_exited.connect(_on_body_exited)
	

func _on_body_entered(body: Node) -> void:
	if body.is_in_group(player_group):
		audiotext.play()
		label.visible = true                  
		
		
#		scroll_text(popup_text)

func _on_body_exited(body: Node) -> void:
	if body.is_in_group(player_group):
		label.visible = false                 
		 



#func scroll_text(input_text:String) -> void:
#	label.visible_characters = 0
	
#	for i in label.get_parsed_text():
#		label.visible_characters += 1
#		await get_tree().create_timer(0.08).timeout
