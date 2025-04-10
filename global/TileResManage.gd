#global script
#class_name TileResManage
extends Node

signal change_terrain(tile_area:MeshArea)
var current_id = 0

class TileDataDetail:
	var nebr_id: Array = []
	var tile:MeshArea
	

var tilenum:int = 0
var tile_data = []

func init_tile_manage(num:int)->void:
	tilenum = num
	tile_data.resize(tilenum)
	tile_data.fill(null)
	for i in range(tilenum):
		tile_data[i] = TileDataDetail.new()

func set_nebr(id:int,nebr_id:Array)->void:#已弃用
	tile_data[id].nebr_id = nebr_id
	pass

func set_tile(tiles:Array)->void:
	for tile:MeshArea in tiles:
		tile_data[tile.id].tile=tile
	pass

func get_current_tile_id()->int:
	return current_id
func set_current_tile_id(new_id:int)->void:
	current_id = new_id


func change_terrain_test(tile_area:MeshArea)->void: #test use
	emit_signal("change_terrain",tile_area)
	
