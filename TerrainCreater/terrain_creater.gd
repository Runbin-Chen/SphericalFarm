extends Node3D
@onready var tile_area_collection: Node3D = $TileAreaCollection
const DESERT_HEX_TILES_A = preload("res://TerrainCreater/hex_tiles/desert_hex_tiles_a.tscn")

func _ready() -> void:
	add_terrain(tile_area_collection.get_child(0))

func add_terrain(tile_area:MeshArea)->void:
	var mesh = tile_area.get_node("GeneratedMesh").mesh
	var center = tile_area.center
	var instance = DESERT_HEX_TILES_A.instantiate()
	# 设置缩放
	instance.scale = Vector3.ONE * 30  # 替换scale为你的缩放值

	# 获取mesh数组数据（假设mesh是ArrayMesh实例）
	var mesh_array = mesh.surface_get_arrays(0)
	var vertices = mesh_array[ArrayMesh.ARRAY_VERTEX]
	var normals = mesh_array[ArrayMesh.ARRAY_NORMAL]

	# 计算第一个面的法线（假设每个顶点法线相同）
	var face_normal = normals[0] if normals else Vector3.UP
	# 或者取三个顶点法线的平均值（适用于平滑面）
	# var face_normal = ((normals[0] + normals[1] + normals[2]) / 3).normalized()

	# 设置实例位置为中心点
	instance.transform.origin = center

	# 计算Y轴朝向法线方向的旋转
	var target_y = face_normal.normalized()
	var current_y = Vector3.UP

	if target_y != current_y:
		if target_y.is_equal_approx(-current_y):
			# 处理反向情况，绕X轴旋转180度
			instance.rotate_object_local(Vector3.RIGHT, PI)
	else:
				# 计算旋转四元数
		var rotation_axis = current_y.cross(target_y).normalized()
		var rotation_angle = current_y.angle_to(target_y)
		instance.rotate(rotation_axis, rotation_angle)

	# 添加实例到场景
	add_child(instance)
