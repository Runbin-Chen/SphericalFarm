extends MarginContainer

@onready var water_label: Label = $VBoxContainer/Panel4/VBoxContainer/HBoxContainer/WaterContainer/WaterLabel
@onready var steel_label: Label = $VBoxContainer/Panel4/VBoxContainer/HBoxContainer/SteelContainer/SteelLabel
@onready var wood_label: Label = $VBoxContainer/Panel4/VBoxContainer/HBoxContainer/WoodContainer/WoodLabel


func _ready() -> void:
	#TimeManage.connect("time_flash",_on_time_flash)
	PlayerResManage.connect("inventory_flash",_on_inventory_flash)
	_on_inventory_flash()
	
func _on_inventory_flash()->void:
	water_label.text = str(PlayerResManage.get_item_count(DataTypes.Item_Type.Water))
	wood_label.text = str(PlayerResManage.get_item_count(DataTypes.Item_Type.Wood))
