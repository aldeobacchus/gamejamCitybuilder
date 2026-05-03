extends Control

signal planet_selected(planetName)

@onready var background = $BgPlanet
@onready var description = $BgPlanet/Description
var planetName: String

func setup(name: String, texture:Texture2D):
	await ready
	description.text = name
	planetName = name
	background.texture = texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("planet_selected", planetName)
