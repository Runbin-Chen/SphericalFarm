extends Node3D

func selected():
	DialogueMange.init_dialogue()
	disp_dialogue()
	DialogueMange.word_pressed.connect(_on_button_pressed)

func disp_dialogue():
	DialogueMange.create_dialogue("采石（-20行动点 石头+50）",1)

func _on_button_pressed(num:int):
	if (num == 1):
		TimeManage.plus_count(10)
		DialogueMange.show_hint("石头+50")
		PlayerResManage.add_item(DataTypes.Item_Type.Stone,50)
