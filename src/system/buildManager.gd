extends Node2D

#tileMap
@export var tileMap: TileMapLayer

#building instance
var selected_building_scene: PackedScene = null

#ghost building for placing
var temp_build_instance: Node2D = null
var is_placing := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#linking UI build buttons
	for button in get_tree().get_nodes_in_group("build_buttons"):
		if button.has_signal("building_selected"):
			button.connect("building_selected", _on_building_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_placing and temp_build_instance:
		temp_build_instance.global_position = getSnappedPosition(get_global_mouse_position())


func _input(event):
	
	#placing the building on click
	if is_placing: #check condition
		if event is InputEventMouseButton and event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				place_building(get_global_mouse_position())

#get mouse position on the tilemap
func getSnappedPosition(pos):
	# global → local du tilemap
	var local_pos = tileMap.to_local(pos)
	# local → coords cellule (iso géré automatiquement)
	var cell = tileMap.local_to_map(local_pos)
	# cellule → position locale (centre de la tile)
	var snapped_local = tileMap.map_to_local(cell)
	# local → global
	return tileMap.to_global(snapped_local)

func enter_build_mode():
	print(tileMap)
	tileMap.modulate = Color(1, 0, 0, 1)

func exit_build_mode():
	tileMap.modulate = Color(1.0, 1.0, 1.0, 0.0)

#building mode
func _on_building_selected(scene: PackedScene):
	selected_building_scene = scene
	enter_build_mode()
	
	if temp_build_instance:
		temp_build_instance.queue_free()
	temp_build_instance = selected_building_scene.instantiate()
	
	if not GameState.canAfford(temp_build_instance.cost):
		print("Not enough resources")
		temp_build_instance.queue_free()
		return
		
	is_placing = true
	
	#previewing ghost
	add_child(temp_build_instance)
	set_preview_visual(temp_build_instance)
	
func set_preview_visual(node):
	for child in node.get_children():
		if child is CanvasItem:
			child.modulate.a = 0.5

func place_building(position: Vector2):
	if selected_building_scene == null:
		return
	
	#paying the cost
	GameState.pay(temp_build_instance.cost)
	
	var building = selected_building_scene.instantiate()		
	building.global_position = getSnappedPosition(position)
	get_parent().get_node("Buildings").add_child(building)
	
	#cancelling preview
	temp_build_instance.queue_free()
	temp_build_instance = null
	
	building.appliesEffect()
	
	is_placing = false
	selected_building_scene = null
