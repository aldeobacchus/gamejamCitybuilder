extends Control

@onready var infoTitle = $PanelContainer/MarginContainer/VBoxContainer/InfoTitle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(bName):
	await ready
	#self infos
	match bName:
		"Main Building":
			infoTitle.text = "Unit creation"
			$PanelContainer/MarginContainer/VBoxContainer/TroopBuilderContainer.visible = true
			
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
