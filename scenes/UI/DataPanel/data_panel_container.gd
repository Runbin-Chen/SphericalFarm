extends MarginContainer

@onready var water_label: Label = $VBoxContainer/Panel4/VBoxContainer/HBoxContainer/WaterContainer/WaterLabel
@onready var wood_label: Label = $VBoxContainer/Panel4/VBoxContainer/HBoxContainer/WoodContainer/WoodLabel
@onready var seed_label: Label = $VBoxContainer/Panel4/VBoxContainer/HBoxContainer/SeedContainer/SeedLabel
@onready var stone_label: Label = $VBoxContainer/Panel4/VBoxContainer/HBoxContainer2/StoneContainer/StoneLabel
@onready var steel_dust_label: Label = $VBoxContainer/Panel4/VBoxContainer/HBoxContainer2/SteelDustContainer/SteelDustLabel
@onready var steel_label: Label = $VBoxContainer/Panel4/VBoxContainer/HBoxContainer2/SteelContainer/SteelLabel
@onready var corn_label: Label = $VBoxContainer/Panel4/VBoxContainer/HBoxContainer3/CornContainer/CornLabel
@onready var apple_label: Label = $VBoxContainer/Panel4/VBoxContainer/HBoxContainer3/AppleContainer/AppleLabel
@onready var carrot_label: Label = $VBoxContainer/Panel4/VBoxContainer/HBoxContainer3/CarrotContainer/CarrotLabel



func _ready() -> void:
	#TimeManage.connect("time_flash",_on_time_flash)
	PlayerResManage.connect("inventory_flash",_on_inventory_flash)
	_on_inventory_flash()
	
func _on_inventory_flash()->void:
	water_label.text = str(PlayerResManage.get_item_count(DataTypes.Item_Type.Water))
	wood_label.text = str(PlayerResManage.get_item_count(DataTypes.Item_Type.Wood))
	steel_label.text = str(PlayerResManage.get_item_count(DataTypes.Item_Type.Steel))
	steel_dust_label.text = str(PlayerResManage.get_item_count(DataTypes.Item_Type.SteelDust))
	seed_label.text = str(PlayerResManage.get_item_count(DataTypes.Item_Type.Seed))
	stone_label.text = str(PlayerResManage.get_item_count(DataTypes.Item_Type.Stone))
	corn_label.text = str(PlayerResManage.get_item_count(DataTypes.Item_Type.Corn))
	apple_label.text = str(PlayerResManage.get_item_count(DataTypes.Item_Type.Apple))
	carrot_label.text = str(PlayerResManage.get_item_count(DataTypes.Item_Type.Carrot))
