@tool
class_name HexPlanetManager
extends Node3D


@export var regenerate: bool = false

var prev_hex_planet: HexPlanet

@onready var hex_planet: HexPlanet = $HexPlanet
@onready var hex_chunk_renders: Node3D = $HexChunkRenders
@onready var tile_areas: Node3D = $TileAreas

const TileArea = preload("res://sphere_creater/tile_area.tscn")

func _ready() -> void:
	update_render_objects()


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
	for i in range(hex_planet.chunks.size()):
		var chunk_obj := HexChunkRender.new()
		chunk_obj.name = "Chunk" + str(i)
		chunk_obj.position = Vector3.ZERO
		chunk_obj.set_hex_chunk(hex_planet, i)
		chunk_obj.update_mesh()
		hex_chunk_renders.add_child(chunk_obj)
		#Array Mesh
		
		#var mesh = chunk_obj.mesh
		#if mesh != null:
			## 打印基础信息
			#print("Mesh资源名称: ", mesh.resource_name)
			#print("Mesh资源路径: ", mesh.resource_path)
			#
			## 如果是ArrayMesh类型
			#if mesh is ArrayMesh:
				#print("表面数量: ", mesh.get_surface_count())
				## 打印每个表面的顶点数
				#for ii in mesh.get_surface_count():
					#var arr = mesh.surface_get_arrays(ii)
					#var vertices = arr[ArrayMesh.ARRAY_VERTEX]
					#print("表面 %d 顶点数: %d" % [ii, vertices.size()])
					#
			## 如果是PrimitiveMesh类型（如BoxMesh/SphereMesh等）
			#elif mesh is PrimitiveMesh:
				#print("基础网格类型: ", mesh.get_class())
				#
		#else:
			#print("警告：未找到关联的网格资源")、
		
		var tile_area_instance = TileArea.instantiate()
		tile_area_instance.set_shape(chunk_obj.mesh)
		tile_areas.add_child(tile_area_instance)
		
