#class_name DataTypes
#global
extends Node

enum Ground_Type{
	None,
	Desert,
	GrassLand,
	Sea
}

const GROUND_COLORS = {
	Ground_Type.None: Color(0, 0, 0, 0),
	Ground_Type.Desert: Color("ffd5be"),
	Ground_Type.GrassLand: Color("7FFF7F"),
	Ground_Type.Sea: Color("7CFC00")
}

enum Terrain_Type{
	None,
	RockCrystal,
	Corridor
}

const Terrain_Scenes = {
	Terrain_Type.RockCrystal : preload("res://scenes/TerrainCreater/hex_tiles/desert_hex_tiles_crystal.tscn"),
	Terrain_Type.Corridor: preload("res://scenes/TerrainCreater/hex_tiles/corridor_hex_tile.tscn")
}
