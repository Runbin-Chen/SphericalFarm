# CornPlant.gd
class_name CornPlant
extends PlantBase


func _ready() -> void:
	germination_node = $GerminationCron
	growth_node = $GrowthCorn 
	mature_node = $MatureCorn
	
	crop_type = DataTypes.Item_Type.Corn
	crop_name = "玉米"
	
	growth_turns = {
		Growth_Type.Seed: TimeManage.turn_per_day * 3,
		Growth_Type.Growth: TimeManage.turn_per_day * 2,
		Growth_Type.Mature: TimeManage.turn_per_day * 1
	}
	
	super._ready()

func harvest() -> int:
	super.harvest()
	return PlayerResManage.get_probability_item(30, 70)
