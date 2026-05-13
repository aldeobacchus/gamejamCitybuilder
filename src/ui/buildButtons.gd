extends Button

signal building_selected(building_scene)

@export var building_scene: PackedScene
var cost := {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var temp = building_scene.instantiate()
	
	cost = temp.cost
	temp.queue_free()
	
	GameState.resourcesChanged.connect(updatePayState)
	updatePayState()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _pressed() -> void:
	emit_signal("building_selected", building_scene)
	
#update state
func updatePayState():
	if GameState.canAfford(cost):
		disabled = false
		modulate = Color(1, 1, 1, 1)   # normal
	else:
		disabled = true
		modulate = Color(0.8, 0.8, 0.8, 1)   # grisé
	
