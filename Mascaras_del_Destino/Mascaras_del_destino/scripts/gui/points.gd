extends CanvasLayer

#Llamada a nodos
@onready var showpoints: RichTextLabel = $showpoints
@onready var showlifes: RichTextLabel = $showlifes

#Variables
var text: String = "Puntos: "
var texttwo: String = "[img=80x80]res://assets/UI/lifes/life.png[/img]x"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	printpoints()
	printlifes()
	
#Funcion para mostrar la puntuacion de la partida en pantalla en el CanvasLayer
func printpoints():
	showpoints.text = text + str( Globalscript.score)
	
#Funcion para mostrar las vidas de la ronda en pantalla en el CanvasLayer
func printlifes():
	showlifes.text = texttwo + str(Globalscript.lives)
