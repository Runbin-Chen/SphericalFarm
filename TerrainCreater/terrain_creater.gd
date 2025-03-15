extends Node3D
@onready var tile_area_collection: Node3D = $TileAreaCollection
const DESERT_HEX_TILES_A = preload("res://TerrainCreater/hex_tiles/desert_hex_tiles_a.tscn")

func _ready() -> void:
	add_terrain(tile_area_collection.get_child(0))

func add_terrain(tile_area:MeshArea)->void:
	#var mesh = tile_area.get_node("GeneratedMesh").mesh
	var center = tile_area.center
	var instance = DESERT_HEX_TILES_A.instantiate()
	#instance.transform.origin += Vector3(0, 1, 0)
	# 设置缩放
	#instance.scale = Vector3.ONE * 30  # 替换scale为你的缩放值

	# 获取mesh数组数据（假设mesh是ArrayMesh实例）
	
	var plane = Plane(tile_area.adjust_vertices[0], tile_area.adjust_vertices[1], tile_area.adjust_vertices[2])

	# 获取归一化的法线向量
	var target_normal = plane.normal
	
	# 设置实例位置为中心点
	instance.transform.origin = center
	

	# 选择一个初始参考方向（例如全局右方向）
	var reference_dir = Vector3.RIGHT

	# 如果参考方向与目标法线几乎平行，改用全局前方向作为参考
	if abs(target_normal.dot(reference_dir)) > 0.9:
		reference_dir = Vector3.FORWARD

	# 计算新的 X 轴（参考方向在法线垂直平面上的投影）
	var new_x = reference_dir - target_normal * target_normal.dot(reference_dir)
	new_x = new_x.normalized()

	# 计算新的 Z 轴（确保与 Y 轴和 X 轴正交）
	var new_z = target_normal.cross(new_x).normalized()

	# 构造新的基底并应用旋转
	instance.transform.basis = Basis(new_x, target_normal, new_z)
	instance.transform.origin += target_normal*-1
	
	instance.scale = Vector3.ONE * 30  # 替换scale为你的缩放值
	# 添加实例到场景
	add_child(instance)
