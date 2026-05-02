extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var button = get_parent().get_child(0)

	if button.building_scene == null:
		text = ""
		return

	var temp = button.building_scene.instantiate()
	var cost = temp.cost
	temp.queue_free()

	text = format_cost(cost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func format_cost(cost: Dictionary) -> String:
	var parts = []

	for key in cost.keys():
		if cost[key] > 0:
			parts.append(key + ": " + str(cost[key]))

	return "\n".join(parts)
