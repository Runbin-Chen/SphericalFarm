extends Node3D
const BUSH_1 = preload("res://assets/import_model/sketchfab/Desert Shrubs/scenes/bush_1.tscn")
const BUSH_2 = preload("res://assets/import_model/sketchfab/Desert Shrubs/scenes/bush_2.tscn")

@onready var bushes: Node3D = $Bushes


func _ready():
	randomize()  # 初始化随机种子
	
	var scenes = [BUSH_1, BUSH_2]
	
	# 生成10个实例（数量可调）
	for i in 2:
		var instance = scenes.pick_random().instantiate()
		instance.position = Vector3(
			randf_range(-0.3, 0.3), 
			0, 
			randf_range(-0.3, 0.3)
		)
		instance.rotation.y = randf() * TAU  # 随机Y轴旋转（0-360度）
		instance.scale = Vector3(0.002, 0.002, 0.002)  # 缩小到原来的0.5倍
		bushes.add_child(instance)
