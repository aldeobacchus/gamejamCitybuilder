class_name Building
extends Node2D

signal clicked(building)

@export var buildingName: String
@export var buildingDescription: String
@export var level: int = 1
@export var isPlaced : bool = false

var area : Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("_ready:"+buildingName)
	if has_node("Area2D"):
		print("building " + buildingName + " has an Area2D")
		area = $Area2D
	area.input_event.connect( _on_area_input_event)
	area.input_pickable = true
	print(area)
	print(area.get_child_count())
	if not isPlaced:
		print("disabling interaction")
		disable_interaction()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup():
	pass

func disable_interaction():
	if has_node("CollisionShape2D"):
		$CollisionShape2D.disabled = true

func onClicked():
	print("Base building clicked, onCLicked not Override")

func  _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not isPlaced:
			print("bat not placed")
			return
		onClicked()
