extends Node2D

var selected_building_scene: PackedScene = null
#ghost building for placing
var preview_building: Node2D = null
var is_placing := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#linking UI build buttons
	for button in get_tree().get_nodes_in_group("build_buttons"):
		if button.has_signal("building_selected"):
			button.connect("building_selected", _on_building_selected)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_placing and preview_building:
		preview_building.global_position = get_global_mouse_position()

func _input(event):
	#check condition
	if is_placing:
		if event is InputEventMouseButton and event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				place_building(get_global_mouse_position())

#building mode
func _on_building_selected(scene):
	selected_building_scene = scene
	is_placing = true
	
	if preview_building:
		preview_building.queue_free()
	
	preview_building = scene.instantiate()
	add_child(preview_building)
	set_preview_visual(preview_building)

func set_preview_visual(node):
	for child in node.get_children():
		if child is CanvasItem:
			child.modulate.a = 0.5

func place_building(position: Vector2):
	if selected_building_scene == null:
		return
	
	var building = selected_building_scene.instantiate()
	building.global_position = position
	$World/Buildings.add_child(building)
	
	#cancelling preview
	preview_building.queue_free()
	preview_building = null
	
	is_placing = false
	selected_building_scene = null
