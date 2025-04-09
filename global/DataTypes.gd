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
	Ground_Type.Sea: Color("7F7FFF")
}
