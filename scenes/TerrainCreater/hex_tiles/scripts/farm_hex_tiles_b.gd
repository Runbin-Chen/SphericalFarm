extends Node3D
@onready var corn_plant: CornPlant = $CornPlant

func _ready() -> void:
	PlayerResManage.add_item(DataTypes.Item_Type.Seed,100)

func selected():
	DialogueMange.init_dialogue()
	disp_dialogue()
	DialogueMange.word_pressed.connect(_on_button_pressed)

func disp_dialogue():
	if corn_plant.state != corn_plant.Growth_Type.None:
		DialogueMange.create_dialogue("生长中",2)
	else:
		DialogueMange.create_dialogue("种植玉米",1)

func _on_button_pressed(num:int):
	if (num == 1):
		if (PlayerResManage.get_item_count(DataTypes.Item_Type.Seed)<10):
			DialogueMange.show_hint("种子不足")
		else:
			if corn_plant.state != corn_plant.Growth_Type.None:
				DialogueMange.show_hint("已种植")
			else:
				PlayerResManage.remove_item(DataTypes.Item_Type.Seed,10)
				corn_plant.init_plant()
				DialogueMange.show_hint("种植成功")
				TimeManage.plus_count(2)
		
