# TomatoPlant.gd (子类)
class_name TomatoPlant
extends PlantBase

func _ready() -> void:
	# 初始化节点引用
	germination_node = $GerminationTomato
	growth_node = $GrowthTomato
	mature_node = $MatureTomato
	
	crop_type = DataTypes.Item_Type.Tomato
	crop_name = "西红柿"
	
	# 配置生长周期
	growth_turns = {
		Growth_Type.Seed: TimeManage.turn_per_day * 2,
		Growth_Type.Growth: TimeManage.turn_per_day * 2,
		Growth_Type.Mature: TimeManage.turn_per_day * 2
	}
	
	# 必须调用父类的_ready
	super._ready()

func harvest() -> int:
	super.harvest()
	return PlayerResManage.get_probability_item(50, 50)
