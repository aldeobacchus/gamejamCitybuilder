extends Building

var cost := {
	"metal": 0,
	"organic": 0,
	"plasma": 0,
	"fuel": 0
}

func _ready() -> void:
	#self infos
	isPlaced = true
	buildingName = "Main Building"
	buildingDescription = "C'est le batiment principal ! C'est ici pour recruter des soldat et des soldates \n Les cinq premiers soldat un peu coolos sont toujours gratuits"

	if has_node("Area2D"):
		area = $Area2D
	area.input_event.connect( _on_area_input_event)
	area.input_pickable = true
	

func onClicked():
	print("Main Building Clicked")
	clicked.emit(self)
