extends Control

var buildingInfoSubClassScene = preload("res://src/ui/buildingInfoSubclass.tscn")

@onready var buildingDescription = $VBoxContainer/VBoxContainer/BuildingDesc
@onready var buildingName = $VBoxContainer/BuildingName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(bName, bDesc):
	await ready
	#self infos
	buildingName.text = bName
	buildingDescription.text = bDesc
	
	#building subclass
	var infoSubclassInstance = buildingInfoSubClassScene.instantiate()
	infoSubclassInstance.setup(bName)
	$VBoxContainer/VBoxContainer/MarginContainer.add_child(infoSubclassInstance)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
