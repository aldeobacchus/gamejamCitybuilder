extends Node


@onready var icon = $HBoxContainer/Icon
@onready var label = $HBoxContainer/Label

@onready var soldier = $HBoxContainer/HBoxTroops/Soldier
@onready var separator = $HBoxContainer/HBoxTroops/Separator
@onready var soldierCapacity = $HBoxContainer/HBoxTroops/SoldierCapacity

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
		"troops":
			soldier.text = str(GameState.resources.soldier)
			separator.text = "/"
			soldierCapacity.text = str(GameState.resources.soldierCapacity)
			icon.texture = preload("res://assets/icon/troops.png")


func update_value(value:int, key: String):
	if key == "label":
		label.text = str(value)
	elif key == "soldier":
		soldier.text = str(value)
	elif key == "soldierCapacity":
		soldierCapacity.text = str(value)
		print("changing soldier capacity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
