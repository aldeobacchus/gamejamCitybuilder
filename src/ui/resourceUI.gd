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
			icon.texture = resizeIcon(preload("res://assets/icon/metal.png"))
		"organic":
			label.text = str(GameState.resources.organic)
			icon.texture = resizeIcon(preload("res://assets/icon/organic.png"))
		"plasma":
			label.text = str(GameState.resources.plasma)
			icon.texture = resizeIcon(preload("res://assets/icon/plasma.png"))
		"fuel":
			label.text = str(GameState.resources.fuel)
			icon.texture = resizeIcon(preload("res://assets/icon/fuel.png"))
		"troops":
			soldier.text = str(GameState.resources.soldier)
			separator.text = "/"
			soldierCapacity.text = str(GameState.resources.soldierCapacity)
			icon.texture = resizeIcon(preload("res://assets/icon/troop.png"))

func resizeIcon(texture):
	var image = texture.get_image()
	image.resize(image.get_width() / 2, image.get_height() / 2)
	var resized_texture = ImageTexture.create_from_image(image)
	return resized_texture

func update_value(value:int, key: String):
	if key == "label":
		label.text = str(value)
	elif key == "soldier":
		soldier.text = str(value)
	elif key == "soldierCapacity":
		soldierCapacity.text = str(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
