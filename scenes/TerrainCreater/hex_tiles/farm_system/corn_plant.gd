class_name CornPlant
extends Node3D
@onready var mature_corn: Node3D = $MatureCorn
@onready var growth_corn: Node3D = $GrowthCorn
@onready var germination_cron: Node3D = $GerminationCron

enum Growth_Type{
	None,
	Seed,
	Growth,
	Mature
}
const Growth_Turns = {
	Growth_Type.Seed: TimeManage.turn_per_day * 2,
	Growth_Type.Growth: TimeManage.turn_per_day * 2,
	Growth_Type.Mature: TimeManage.turn_per_day * 2
}

var state:Growth_Type 
var last_state_time : int

func clear_visible()->void:
	for node in get_children():
		node.visible = false

func _ready() -> void:
	clear_visible()
	state = Growth_Type.None
	TimeManage.time_flash.connect(_in_time_flash)

#func get_u_time()->int:
	#return TimeManage.get_current_day()*TimeManage.turn_per_day+TimeManage.get_current_turn()

func init_plant()->void:
	state = Growth_Type.Seed
	last_state_time = TimeManage.get_current_day()*TimeManage.turn_per_day+TimeManage.get_current_turn()
	#get_node("MatureCorn").visible = true
	
func _in_time_flash(day:int,turn:int)->void:
	if state == Growth_Type.None:
		return
	var expect_time= last_state_time+ Growth_Turns[state]
	if (day*TimeManage.turn_per_day+turn>=expect_time):
		last_state_time = expect_time
		if state == Growth_Type.Seed:
			state = Growth_Type.Growth
			clear_visible()
			germination_cron.visible = true
			return
		if state == Growth_Type.Growth:
			state = Growth_Type.Mature
			clear_visible()
			growth_corn.visible = true
			return
		if state == Growth_Type.Mature:
			state = Growth_Type.Mature
			clear_visible()
			mature_corn.visible = true
			return
			
