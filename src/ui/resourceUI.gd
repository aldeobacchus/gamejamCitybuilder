extends Node


@onready var icon = $HBoxContainer/Icon
@onready var label = $HBoxContainer/Label
var resourceType : String


func setup(type: String):
	await ready
	resourceType = type
	match type:
		"metal":
			label.text = str(GameState.resources.metal)
			icon.texture = preload("res://assets/icon/metal.png")
		"organic":
			label.text = str(GameState.resources.organic)
			icon.texture = preload("res://assets/icon/metal.png")
		"plasma":
			label.text = str(GameState.resources.plasma)
			icon.texture = preload("res://assets/icon/metal.png")
		"fuel":
			label.text = str(GameState.resources.fuel)
			icon.texture = preload("res://assets/icon/metal.png")

func update_value(value:int):
	label.text = str(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
