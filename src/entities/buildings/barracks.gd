extends Building

@export var capacityBonus : int = 5

var cost := {
	"metal": 500,
	"organic": 0,
	"plasma": 0,
	"fuel": 0
}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#to call when the building is placed
func setup():
	print("intit building")
	isPlaced = true
	buildingName = "Barracks"
	appliesEffect()

func onClicked():
	print("Barracksssss")

func appliesEffect() -> void:
	GameState.addResource("soldierCapacity", capacityBonus)
