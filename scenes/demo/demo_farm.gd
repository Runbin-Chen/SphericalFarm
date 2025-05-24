extends Node3D
@onready var corn_plant: CornPlant = $CornPlant
@onready var tomato_plant: TomatoPlant = $TomatoPlant

func _ready() -> void:
	tomato_plant.init_plant()
	for i in 10:
		await get_tree().create_timer(1).timeout
		TimeManage.next_day()
		
