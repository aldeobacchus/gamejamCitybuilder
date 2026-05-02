extends Control

#EXPEDITION
@onready var vbox = $ExpeditionTab/ScrollContainer/ExpeditionsList
@onready var expeditionButton = $ExpeditionTab/ExpeditionButton
@onready var hideExpedition = $ExpeditionTab/HideExpedition
var planetItemScene = preload("res://src/ui/PlanetItem.tscn")

#RESOURCES
@onready var hboxRes = $ResourcesTab/HBoxContainer
var resourceUI = preload("res://src/ui/ResourceUI.tscn")# preload de la scene de chaque resources
var resourceDict = {}

#DEBUG
@onready var dMenuButton = $DebugUI/MenuButton
var dSelectedResource = "metal"
var dResList = ["metal", "organic", "plasma", "fuel"]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#connecting all the signals
	expeditionButton.connect("showExpedition", _on_show_expedition)
	hideExpedition.connect("hideExpedition", _on_hide_expedition)
	GameState.resourcesChanged.connect(update_resources)
	
	#Instanciate planets in expedition tab
	createPlanet("Zborg",preload("res://assets/planets/Planete1.png"))
	createPlanet("Super mechant ville", preload("res://assets/planets/Planete2.png"))
	createPlanet("Mignon planete", preload("res://assets/planets/Planete3.png"))
	createPlanet("BHAAAAAA", preload("res://assets/planets/Planete4.png"))

	#Instanciates resources UI in top bar
	createResource("metal")
	createResource("organic")
	createResource("plasma")
	createResource("fuel")
	createResource("troops")
	
	#DEBUG UI
	var popup = dMenuButton.get_popup()
	for r in dResList:
		popup.add_item(r)
	popup.id_pressed.connect(_dOnResSelected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func createPlanet(name: String, texture:Texture2D):
	var item = planetItemScene.instantiate()
	item.setup(name, texture)
	vbox.add_child(item)

func createResource(type:String):
	var res = resourceUI.instantiate()
	res.setup(type)
	hboxRes.add_child(res)
	resourceDict[type] = res

func _on_show_expedition():
	$ExpeditionTab/ScrollContainer.visible = true
	$ExpeditionTab/HideExpedition.visible = true
	$ExpeditionTab/ExpeditionButton.visible = false

func _on_hide_expedition():
	$ExpeditionTab/ScrollContainer.visible = false
	$ExpeditionTab/HideExpedition.visible = false
	$ExpeditionTab/ExpeditionButton.visible = true

#update UI
func update_resources():
	for type in resourceDict:
		if type == "troops":
			var soldier = GameState.getResourceValue("soldier")
			var soldierCapacity = GameState.getResourceValue("soldierCapacity")
			resourceDict[type].update_value(soldier, "soldier")
			resourceDict[type].update_value(soldierCapacity, "soldierCapacity")
		else:
			var value = GameState.getResourceValue(type)
			resourceDict[type].update_value(value, "label")

#debug
func _dOnResSelected(id):
	dSelectedResource = dResList[id]
	dMenuButton.text = dSelectedResource

func _dOnAddTen():
	for type in resourceDict:
		var value = GameState.getResourceValue(type)
		print(type + ":" + str(value))
	GameState.addResource(dSelectedResource, 100)

func _dOnRemoveTen():
	GameState.removeResource(dSelectedResource, 100)
