extends Control

#EXPEDITION
@onready var vbox = $ExpeditionTab/PanelContainer/MarginContainer/ScrollContainer/ExpeditionsList
@onready var expeditionButton = $ExpeditionTab/ExpeditionButton
@onready var hideExpedition = $ExpeditionTab/HideExpedition
var planetItemScene = preload("res://src/ui/PlanetItem.tscn")
var planetMissionScene = preload("res://src/ui/PlanetMission.tscn")
var buildingInfoScene = preload("res://src/ui/BuildingInfo.tscn")

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
	expeditionButton.connect("showExpeditionTab", _on_show_expedition)
	hideExpedition.connect("hideExpedition", _on_hide_expedition)
	
	GameState.resourcesChanged.connect(update_resources)
	
	#Instanciate planets in expedition tab
	createPlanet("Zborg",preload("res://assets/planets/Planete1.png"), preload("res://assets/entity/monsters/monstre_metal.png"))
	createPlanet("Super mechant ville", preload("res://assets/planets/Planete2.png"), preload("res://assets/entity/monsters/monstre_fuel.png"))
	createPlanet("Mignon planete", preload("res://assets/planets/Planete3.png"), preload("res://assets/entity/monsters/monstre_organic.png"))
	createPlanet("BHAAAAAA", preload("res://assets/planets/Planete4.png"), preload("res://assets/entity/monsters/monstre_sable.png"))
	createPlanet("testouille", preload("res://assets/planets/Planete4.png"), preload("res://assets/entity/monsters/monstre_metal.png"))
	createPlanet("BHAAAAAA", preload("res://assets/planets/Planete4.png"), preload("res://assets/entity/monsters/monstre_fuel.png"))
	createPlanet("BHAAAAAA", preload("res://assets/planets/Planete4.png"), preload("res://assets/entity/monsters/monstre_organic.png"))
	createPlanet("BHAAAAAA", preload("res://assets/planets/Planete4.png"), preload("res://assets/entity/monsters/monstre_fuel.png"))


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

func createPlanet(name: String, texture:Texture2D, monsterImg: Texture2D):
	var item = planetItemScene.instantiate()
	item.setup(name, texture, monsterImg)
	#on connect le signal maintenant pour gagner de la ressource sur le ready
	item.planet_selected.connect(_on_planet_selected)
	vbox.add_child(item)

func createResource(type:String):
	var res = resourceUI.instantiate()
	res.setup(type)
	hboxRes.add_child(res)
	resourceDict[type] = res

func _on_show_expedition():
	$ExpeditionTab/PanelContainer.visible = true
	$ExpeditionTab/HideExpedition.visible= true
	$ExpeditionTab/ExpeditionButton.visible = false

func _on_hide_expedition():
	$ExpeditionTab/PanelContainer.visible = false
	$ExpeditionTab/HideExpedition.visible = false
	$PlanetTab.visible = false
	$BuildingsTab.visible = true
	$ExpeditionTab/ExpeditionButton.visible = true
	$ResourcesTab.visible = true
	

func _on_planet_selected(planet: Control):
	#clean child of Planet Tab
	for child in $PlanetTab/PanelContainer/MarginContainer.get_children():
		child.queue_free()
	print("showing mission : " + name)
	$ResourcesTab.visible = false
	$BuildingsTab.visible = false
	$PlanetTab.visible = true
	var planetMission = planetMissionScene.instantiate()
	planetMission.setup(planet.planetName, planet.monsterImg)
	$PlanetTab/PanelContainer/MarginContainer.add_child(planetMission)
	var instanciatedChild = $PlanetTab/PanelContainer/MarginContainer.get_child(0)
	instanciatedChild.visible = true

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

func showBuildingInfo(building):
	$BuildingInfoContainer.visible = true
	$BuildingsTab.visible = false
	$ExpeditionTab.visible = false
	for child in $BuildingInfoContainer/PanelContainer/MarginContainer.get_children():
		child.queue_free()
	print("showing building : " + building.buildingName)
	var buildingInfoInstance = buildingInfoScene.instantiate()
	buildingInfoInstance.setup(building.buildingName, building.buildingDescription)
	$BuildingInfoContainer/PanelContainer/MarginContainer.add_child(buildingInfoInstance)
	
func hideBuildingInfo():
	$BuildingInfoContainer.visible = false
	for child in $BuildingInfoContainer/PanelContainer/MarginContainer.get_children():
		child.queue_free()
	$ExpeditionTab.visible = true
	$BuildingsTab.visible = true

#DEBUG
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
