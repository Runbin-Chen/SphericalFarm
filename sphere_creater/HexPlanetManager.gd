#@tool
class_name HexPlanetManager
extends Node3D


@export var regenerate: bool = false

var prev_hex_planet: HexPlanet

@onready var hex_planet: HexPlanet = $HexPlanet
@onready var hex_chunk_renders: Node3D = $HexChunkRenders
@onready var tile_area_collection: Node3D = $TileAreaCollection
const tile_path = "res://sphere_creater/saved_tile/tile_area_collection_saved.tscn"

const TileArea = preload("res://sphere_creater/tile_area.tscn")

func _ready() -> void:
	var tile_area_collection_new = load_node_from_scene(tile_path)
	if tile_area_collection_new!=null:
		remove_child(tile_area_collection)
		add_child(tile_area_collection_new)
		tile_area_collection = tile_area_collection_new
	else:
		update_render_objects()
		save_node_as_scene(tile_area_collection,tile_path)


func _process(delta: float) -> void:
	if regenerate:
		update_render_objects()
		regenerate = false


func update_render_objects() -> void:
	# 删除所有子节点
	for child in hex_chunk_renders.get_children():
		child.queue_free()
	if hex_planet == null:
		return
	HexPlanetHexGenerator.generate_planet_tiles_and_chunks(hex_planet)
	hex_chunk_renders.visible = false #不可见原渲染
	for i in range(hex_planet.chunks.size()):
		var chunk_obj := HexChunkRender.new()
		chunk_obj.name = "Chunk" + str(i)
		chunk_obj.position = Vector3.ZERO
		chunk_obj.set_hex_chunk(hex_planet, i)
		chunk_obj.update_mesh()
		hex_chunk_renders.add_child(chunk_obj)
		
		var tile_area_instance : MeshArea = TileArea.instantiate()
		tile_area_instance.init(chunk_obj.chunk.id)
		tile_area_instance.set_shape(chunk_obj.mesh)
		#tile_area_instance.name = "TileArea" + str(i)
		
		#chunk_id映射到hextile上获得neighbor信息
		for tile:HexTile in hex_planet.tiles:
			if tile.chunk_id == chunk_obj.chunk.id:
				for nbr:HexTile in tile.get_neighbors():
					tile_area_instance.neighbors_id.append(nbr.chunk_id)
		
		tile_area_collection.add_child(tile_area_instance)
		set_owner_recursive(tile_area_instance,tile_area_collection)
		#tile_area_instance.owner = tile_area_collection

# 递归设置所有子节点的 owner
func set_owner_recursive(node: Node, owner: Node) -> void:
	node.owner = owner
	for child in node.get_children():
		set_owner_recursive(child, owner)

func save_node_as_scene(node: Node, path: String) -> void:
	var packed_scene = PackedScene.new()
	# 打包节点及其所有子节点
	packed_scene.pack(node)
	# 保存为场景文件（如 "user://saved_node.tscn"）
	ResourceSaver.save(packed_scene, path)
	
func load_node_from_scene(path: String) -> Node:
	if not FileAccess.file_exists(path):
		print("场景文件不存在: " + path)
		return null
	# 加载打包场景
	var packed_scene = load(path)
	# 实例化节点（包括所有子节点）
	var node = packed_scene.instantiate()
	return node
