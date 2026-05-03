extends Node2D

@export var buildingName: String = "Armurerie"

var cost := {
	"metal": 1000,
	"organic": 250,
	"plasma": 100,
	"fuel": 0
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func appliesEffect() -> void:
	pass
