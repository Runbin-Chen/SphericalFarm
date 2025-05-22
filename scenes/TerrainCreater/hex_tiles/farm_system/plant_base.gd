# PlantBase.gd (基类)
class_name PlantBase
extends Node3D

enum Growth_Type {
	None,
	Seed,
	Growth,
	Mature,
	Harvest
}

# 需要在子类中初始化的变量
var germination_node: Node3D
var growth_node: Node3D
var mature_node: Node3D
var growth_turns: Dictionary

var state: Growth_Type = Growth_Type.None
var last_state_time: int

var crop_type : DataTypes.Item_Type
var crop_name : String

func clear_visible() -> void:
	for node in get_children():
		if node is Node3D:
			node.visible = false

func _ready() -> void:
	assert(growth_turns != null, "growth_turns must be initialized in subclass")
	assert(germination_node != null, "germination_node must be initialized in subclass")
	assert(growth_node != null, "growth_node must be initialized in subclass")
	assert(mature_node != null, "mature_node must be initialized in subclass")
	
	clear_visible()
	TimeManage.time_flash.connect(_in_time_flash)

func harvest() -> int:
	clear_visible()
	state = Growth_Type.None
	return 0  # 需要在子类中重写

func init_plant() -> void:
	state = Growth_Type.Seed
	last_state_time = TimeManage.get_current_day() * TimeManage.turn_per_day + TimeManage.get_current_turn()

func _in_time_flash(day: int, turn: int) -> void:
	if state == Growth_Type.None or state == Growth_Type.Harvest:
		return
	
	var current_time = day * TimeManage.turn_per_day + turn
	var expect_time = last_state_time + growth_turns.get(state, 0)
	
	if current_time >= expect_time:
		last_state_time = expect_time
		match state:
			Growth_Type.Seed:
				state = Growth_Type.Growth
				clear_visible()
				germination_node.visible = true
			Growth_Type.Growth:
				state = Growth_Type.Mature
				clear_visible()
				growth_node.visible = true
			Growth_Type.Mature:
				state = Growth_Type.Harvest
				clear_visible()
				mature_node.visible = true

func get_crop_type()->int:
	return crop_type

func get_crop_name()->String:
	return crop_name
