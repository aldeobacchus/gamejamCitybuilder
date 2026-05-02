extends Control

@onready var vbox = $ExpeditionTab/ScrollContainer/ExpeditionsList
@onready var expeditionButton = $ExpeditionTab/ExpeditionButton
@onready var hideExpedition = $ExpeditionTab/HideExpedition

var planetItemScene = preload("res://src/ui/PlanetItem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	expeditionButton.connect("showExpedition", _on_show_expedition)
	hideExpedition.connect("hideExpedition", _on_hide_expedition)
	
	createPlanet("Zborg",preload("res://assets/planets/Planete1.png"))
	createPlanet("Super mechant ville", preload("res://assets/planets/Planete2.png"))
	createPlanet("Mignon planete", preload("res://assets/planets/Planete3.png"))
	createPlanet("BHAAAAAA", preload("res://assets/planets/Planete4.png"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


var selectedObject = null :
	get:
		return selectedObject
	set(value):
		selectedObject = value;
		if value != null:
			# si on selectionne quelque chose on va afficher tel ou tel node
			# $InfoPanel.visible = true
			# on check la class de la value selectionnee
			#match value.get_class():
				# on assigne la bonne scene (batiment) a building scene
				# building_scene = ...
				# emit_signal("building_selected", building_scene)
			pass

#setter
func setSelectedObject(obj):
	selectedObject = obj

func createPlanet(name, texture):
	var item = planetItemScene.instantiate()
	item.setup(name, texture)
	vbox.add_child(item)

func _on_show_expedition():
	$ExpeditionTab/ScrollContainer.visible = true
	$ExpeditionTab/HideExpedition.visible = true
	$ExpeditionTab/ExpeditionButton.visible = false

func _on_hide_expedition():
	$ExpeditionTab/ScrollContainer.visible = false
	$ExpeditionTab/HideExpedition.visible = false
	$ExpeditionTab/ExpeditionButton.visible = true
