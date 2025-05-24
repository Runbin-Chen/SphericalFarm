extends Node3D

const BUSH_1 = preload("res://assets/import_model/sketchfab/greenhouse_foliage/scenes/bush_1.tscn")
const BUSH_2 = preload("res://assets/import_model/sketchfab/greenhouse_foliage/scenes/bush_2.tscn")
const GRASS_1 = preload("res://assets/import_model/sketchfab/greenhouse_foliage/scenes/grass_1.tscn")
const GRASS_2 = preload("res://assets/import_model/sketchfab/greenhouse_foliage/scenes/grass_2.tscn")

func _ready():
	randomize()  # 初始化随机种子
	
	var scenes = [BUSH_1, BUSH_2, GRASS_1, GRASS_2]
	
	# 生成10个实例（数量可调）
	for i in 10:
		var instance = scenes.pick_random().instantiate()
		instance.position = Vector3(
			randf_range(-0.5, 0.5), 
			0, 
			randf_range(-0.5, 0.5)
		)
		instance.rotation.y = randf() * TAU  # 随机Y轴旋转（0-360度）
		instance.scale = Vector3(0.2, 0.2, 0.2)  # 缩小到原来的0.5倍
		add_child(instance)
