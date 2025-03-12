extends Node3D

func _ready():
	# 获取子节点 Chunk0（MeshInstance3D）
	var chunk = get_node("Chunk0")  # 或者直接写 $Chunk0
	if not chunk:
		print("错误：找不到子节点 Chunk0！")
		return

	# 获取 Mesh 资源
	var mesh = chunk.mesh
	if not mesh:
		print("错误：Chunk0 没有附加 Mesh！")
		return

	# 如果是 PrimitiveMesh（如 Cube、Sphere），需要转为 ArrayMesh
	if mesh is PrimitiveMesh:
		mesh = mesh.get_mesh()  # 转换为 ArrayMesh

	# 遍历 Mesh 的每个表面（Surface）
	for surface_id in range(mesh.get_surface_count()):
		print("==== 表面 %d ====" % surface_id)
		# 获取表面数据（顶点数组的索引是 Mesh.ARRAY_VERTEX = 0）
		var surface_data = mesh.surface_get_arrays(surface_id)
		var vertices = surface_data[Mesh.ARRAY_VERTEX]

		if vertices == null or vertices.size() == 0:
			print("该表面没有顶点数据！")
			continue

		# 打印所有顶点坐标
		for i in range(vertices.size()):
			var v = vertices[i]
			print("顶点 %d: (%.2f, %.2f, %.2f)" % [i, v.x, v.y, v.z])
