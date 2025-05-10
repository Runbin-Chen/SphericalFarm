extends Node3D
@onready var tile_area_collection: Node3D = $TileAreaCollection
#const DESERT_HEX_TILES_A = preload("res://scenes/TerrainCreater/hex_tiles/desert_hex_tiles_crystal.tscn")
#const corridor_hex_tile = preload("res://scenes/TerrainCreater/hex_tiles/corridor_hex_tile.tscn")

func _ready() -> void:
	var tiles = tile_area_collection.get_children()
	#add_terrain(tiles[27])
	for tile:MeshArea in tiles:
		if tile.id == 28 ||tile.id == 60:
			#pass
			add_terrain(tile,DataTypes.Terrain_Type.RockCrystal)
		if tile.id == 42 || tile.id == 17:
			add_terrain(tile,DataTypes.Terrain_Type.Corridor)
		if tile.id == 77:
			add_terrain(tile,DataTypes.Terrain_Type.Savanna)
		if tile.id == 75:
			add_terrain(tile,DataTypes.Terrain_Type.Forest)
	init_tile_res_manage(tiles)
	TileResManage.connect("change_terrain",_on_change_terrain)
	
	#print(tiles.size())

func add_terrain(tile_area:MeshArea,Terrain_type:DataTypes.Terrain_Type)->void:
	#var mesh = tile_area.get_node("GeneratedMesh").mesh
	#print(tile_area.center)
	var instance
	
	if (Terrain_type != DataTypes.Terrain_Type.None):
		instance = DataTypes.Terrain_Scenes.get(Terrain_type).instantiate()
	else :
		return
	
	var center = tile_area.center
	

	#构建面
	var plane = Plane(tile_area.adjust_vertices[0], tile_area.adjust_vertices[1], tile_area.adjust_vertices[2])

	# 获取归一化的法线向量
	var target_normal = plane.normal
	
	# 设置实例位置为中心点
	instance.transform.origin = Vector3(center[0],center[1],center[2])
	
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
	instance.transform.origin += target_normal*-1.7
	
	instance.scale = Vector3.ONE * 23  # 替换scale为你的缩放值
	# 添加实例到场景
	instance.name="Terrain"
	tile_area.add_child(instance)

func _on_change_terrain(tile_area:MeshArea)->void:
	#print("_on_change_terrain")
	var nodes = tile_area.get_children()
	for node in nodes:
		if node.name == "Terrain":
			#print("found")
			node.queue_free()
	add_terrain(tile_area,DataTypes.Terrain_Type.None)

func init_tile_res_manage(tiles:Array)->void:
	TileResManage.init_tile_manage(tiles.size())
	TileResManage.set_tile(tiles)
	#for tile:MeshArea in tiles:
	#	TileResManage.set_nebr(tile.id,tile.neighbors_id)
	pass
