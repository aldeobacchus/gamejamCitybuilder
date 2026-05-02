extends Node
#const
const METAL = "metal"
const ORGANIC = "organic"
const PLASMA = "plasma"
const FUEL = "fuel"

#resources
signal resourcesChanged()
var resources := ResourceData.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Get resource value
func getResourceValue(type:String):
	return resources.get(type)

func getCost(type:String) -> Dictionary:
	return resources.get(type)

#adding resources to game state
func addResource(type:String, amount:int):
	var current = resources.get(type)
	resources.set(type, current + amount)
	print(str(current) + str(amount))
	emit_signal("resourcesChanged")

#removing resources to game state
func removeResource(type:String, amount:int):
	var current = resources.get(type)
	resources.set(type, max((current - amount), 0))
	emit_signal("resourcesChanged")

#generic function to check if we can afford a building
func canAfford(cost: Dictionary) -> bool:
	for type in cost.keys():
		if getResourceValue(type) < cost[type]:
			return false
	return true

func pay(cost: Dictionary):
	for type in cost.keys():
		removeResource(type, cost[type])
