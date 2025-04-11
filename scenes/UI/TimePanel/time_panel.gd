extends MarginContainer

@onready var day_label: Label = $"VBoxContainer/Panel/VBoxContainer/Day Label"
@onready var turn_label: Label = $"VBoxContainer/Panel2/VBoxContainer/Turn Label"


func _ready() -> void:
	TimeManage.connect("time_flash",_on_time_flash)
	day_label.text = "DAY 0"
	turn_label.text = "TURN 0"
	

func _on_time_flash(day:int,count:int)->void:
	day_label.text = "DAY "+ str(TimeManage.get_current_day()) 
	turn_label.text = "TURN " + str(TimeManage.get_current_turn())
	pass
