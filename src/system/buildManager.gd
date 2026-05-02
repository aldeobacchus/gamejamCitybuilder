extends Node2D

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
		temp_build_instance.global_position = get_global_mouse_position()


func _input(event):
	
	#placing the building on click
	if is_placing: #check condition
		if event is InputEventMouseButton and event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				place_building(get_global_mouse_position())

#building mode
func _on_building_selected(scene: PackedScene):
	selected_building_scene = scene
	
	
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
	building.global_position = position
	get_parent().get_node("Buildings").add_child(building)
	
	#cancelling preview
	temp_build_instance.queue_free()
	temp_build_instance = null
	
	is_placing = false
	selected_building_scene = null
