#global script
#class_name TileResManage
extends Node

class TileDataDetail:
	var nebr_id: Array = []
	


var tilenum:int = 0
var tile_data = []

func init_tile_manage(num:int)->void:
	tilenum = num
	tile_data.resize(tilenum)
	tile_data.fill(null)
	for i in range(tilenum):
		tile_data[i] = TileDataDetail.new()

func set_nebr(id:int,nebr_id:Array)->void:
	tile_data[id].nebr_id = nebr_id
	pass
