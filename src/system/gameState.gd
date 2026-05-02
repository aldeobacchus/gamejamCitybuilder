extends Node

var resources := ResourceData.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func addRessource(type:String, amount:int):
	match type:
		"metal":
			resources.metal += amount
		"organic":
			resources.organic += amount
		"plasma":
			resources.plasma += amount
		"fuel":
			resources.fuel += amount
		"soldierCapacity":
			resources.soldierCapacity += amount
		"soldier":
			resources.soldier += amount

func removeResource(type:String, amount:int):
	match type:
		"metal":
			resources.metal = max((resources.metal - amount), 0)
		"organic":
			resources.organic = max((resources.organic - amount), 0)
		"plasma":
			resources.plasma = max((resources.plasma - amount), 0)
		"fuel":
			resources.fuel = max((resources.fuel - amount), 0)
		"soldier":
			resources.soldier = max((resources.soldier - amount), 0)
