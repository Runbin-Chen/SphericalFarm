extends Node3D
@onready var tile_area_collection: Node3D = $TileAreaCollection
#const DESERT_HEX_TILES_A = preload("res://scenes/TerrainCreater/hex_tiles/desert_hex_tiles_crystal.tscn")
#const corridor_hex_tile = preload("res://scenes/TerrainCreater/hex_tiles/corridor_hex_tile.tscn")

func _ready() -> void:
	var tiles = tile_area_collection.get_children()
	#add_terrain(tiles[27])
	for tile:MeshArea in tiles:
		if tile.id == 42 || tile.id == 17:
			add_terrain(tile,DataTypes.Terrain_Type.Corridor)
		if tile.id == 77:
			add_terrain(tile,DataTypes.Terrain_Type.Savanna)
		if tile.id == 75:
			add_terrain(tile,DataTypes.Terrain_Type.Forest)
		if tile.id == 50:
			add_terrain(tile,DataTypes.Terrain_Type.Farm_A)
		if tile.id == 13:
			add_terrain(tile,DataTypes.Terrain_Type.Farm_B)
		if tile.id == 66:
			add_terrain(tile,DataTypes.Terrain_Type.Rock_A)
	init_tile_res_manage(tiles)
	TileResManage.connect("change_terrain",_on_change_terrain)
	
	add_terrain_batch(tiles,[38,54,144,75,76,19],DataTypes.Terrain_Type.Forest,DataTypes.Ground_Type.GrassLand) #森林
	add_terrain_batch(tiles,[51,78,1,79,83,81,20,70,56,57,82,87,21],DataTypes.Terrain_Type.Sea,DataTypes.Ground_Type.Sea) #海
	add_terrain_batch(tiles,[52,14,58,0,7,145,88,85,84,80,2,86,45,46,47,53,74,73,18,71],DataTypes.Terrain_Type.GrassLand_A,DataTypes.Ground_Type.GrassLand) #纯绿地
	add_terrain_batch(tiles,[50],DataTypes.Terrain_Type.Farm_A,DataTypes.Ground_Type.FarmLand) #农场
	add_terrain_batch(tiles,[13],DataTypes.Terrain_Type.Farm_B,DataTypes.Ground_Type.FarmLand) #耕地
	add_terrain_batch(tiles,[55,64,67,118,44,134,138,141],DataTypes.Terrain_Type.Desert_Plant_A,DataTypes.Ground_Type.Desert) #沙漠
	add_terrain_batch(tiles,[113,140,28,60],DataTypes.Terrain_Type.RockCrystal,DataTypes.Ground_Type.Desert) #矿物
	#add_terrain_batch(tiles,[59,64,65,45,46],DataTypes.Terrain_Type.None,DataTypes.Ground_Type.SavannaLand) #稀树草原
	#add_terrain_batch(tiles,[77],DataTypes.Terrain_Type.Savanna,DataTypes.Ground_Type.SavannaLand) #稀树草原
	#print(tiles.size())

func  set_tile_ground_batch(ids:Array,ground_type:DataTypes.Ground_Type)->void:
	for id in ids:
		TileResManage.set_tile_ground(id,ground_type)
	

func add_terrain_batch(tiles,nums:Array,terrain_type:DataTypes.Terrain_Type,ground_type:DataTypes.Ground_Type)->void:
	for tile:MeshArea in tiles:
		if nums.has(tile.id):
			add_terrain(tile,terrain_type)
	set_tile_ground_batch(nums,ground_type)

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
