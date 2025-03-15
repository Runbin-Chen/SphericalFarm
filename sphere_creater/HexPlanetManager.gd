@tool
class_name HexPlanetManager
extends Node3D


@export var regenerate: bool = false

var prev_hex_planet: HexPlanet

@onready var hex_planet: HexPlanet = $HexPlanet
@onready var hex_chunk_renders: Node3D = $HexChunkRenders
@onready var tile_area_collection: Node3D = $TileAreaCollection


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
		
