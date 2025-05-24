extends Node3D

@export var instance_count = 200  # 调整生成数量

func _ready():
	# 加载预制场景
	var mesh_scene = preload("res://scenes/main_scene/star_instance.tscn")
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	for i in range(instance_count):
		# 实例化节点
		var instance = mesh_scene.instantiate()
		add_child(instance)
		
		# 生成随机半径（400-1000）
		var radius = rng.randf_range(400.0, 2000.0)
		
		# 生成均匀分布的球面坐标
		var u = rng.randf()
		var v = rng.randf()
		var theta = acos(2 * u - 1.0)  # 极角
		var phi = 2 * PI * v           # 方位角
		
		# 转换为3D坐标
		var x = radius * sin(theta) * cos(phi)
		var y = radius * sin(theta) * sin(phi)
		var z = radius * cos(theta)
		
		# 设置实例位置
		instance.position = Vector3(x, y, z)
