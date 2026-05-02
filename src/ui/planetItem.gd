extends Control

@onready var background = $BgPlanet
@onready var description = $BgPlanet/Description

func setup(name: String, texture:Texture2D):
	await ready
	description.text = name
	background.texture = texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
