extends MarginContainer

@onready var day_label: Label = $"VBoxContainer/Panel/VBoxContainer/Day Label"
@onready var turn_label: Label = $"VBoxContainer/Panel2/VBoxContainer/Turn Label"
@onready var turn_button: Button = $VBoxContainer/HBoxContainer/Panel/TurnButton
@onready var day_button: Button = $VBoxContainer/HBoxContainer/Panel2/DayButton


func _ready() -> void:
	TimeManage.connect("time_flash",_on_time_flash)
	day_label.text = "DAY 0"
	turn_label.text = "TURN 0"
	

func _on_time_flash(day:int,count:int)->void:
	day_label.text = "DAY "+ str(TimeManage.get_current_day()) 
	turn_label.text = "TURN " + str(TimeManage.get_current_turn())
	pass



func _on_turn_button_pressed() -> void:
	TimeManage.next_count()
	pass # Replace with function body.



func _on_day_button_pressed() -> void:
	TimeManage.next_day()
	pass # Replace with function body.
