extends MarginContainer

@onready var water_label: Label = $VBoxContainer/Panel4/VBoxContainer/HBoxContainer/HBoxContainer/WaterLabel
@onready var steel_label: Label = $VBoxContainer/Panel4/VBoxContainer/HBoxContainer/HBoxContainer2/SteelLabel

func _ready() -> void:
	#TimeManage.connect("time_flash",_on_time_flash)
	PlayerResManage.connect("inventory_flash",_on_inventory_flash)
	
func _on_inventory_flash()->void:
	water_label.text = str(PlayerResManage.DataTypes.Item_Type.Water)
	
