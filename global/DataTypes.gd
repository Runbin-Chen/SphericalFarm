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
	Ground_Type.GrassLand: Color("0e8905"),
	Ground_Type.Sea: Color("7CFC00")
}

enum Terrain_Type{
	None,
	RockCrystal,
	Corridor,
	Savanna,
	Forest,
	Farm_A,
	Farm_B
}

const Terrain_Scenes = {
	Terrain_Type.RockCrystal : preload("res://scenes/TerrainCreater/hex_tiles/desert_hex_tiles_crystal.tscn"),
	Terrain_Type.Corridor: preload("res://scenes/TerrainCreater/hex_tiles/corridor_hex_tile.tscn"),
	Terrain_Type.Savanna: preload("res://scenes/TerrainCreater/hex_tiles/savanna_hex_tiles_a.tscn"),
	Terrain_Type.Forest: preload("res://scenes/TerrainCreater/hex_tiles/forest_hex_tiles_a.tscn"),
	Terrain_Type.Farm_A: preload("res://scenes/TerrainCreater/hex_tiles/farm_hex_tiles_a.tscn"),
	Terrain_Type.Farm_B: preload("res://scenes/TerrainCreater/hex_tiles/farm_hex_tiles_b.tscn"),
}

enum Item_Type{
	None,
	Water,
	Seed,
	Steel
}
