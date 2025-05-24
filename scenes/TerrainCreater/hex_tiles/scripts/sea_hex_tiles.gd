extends Node3D

func selected():
	DialogueMange.init_dialogue()
	disp_dialogue()
	DialogueMange.word_pressed.connect(_on_button_pressed)

func disp_dialogue():
	DialogueMange.create_dialogue("取水（-10行动点 +50未净化水）",1)

func _on_button_pressed(num:int):
	if (num == 1):
		PlayerResManage.add_item(DataTypes.Item_Type.Water,50)
		TimeManage.plus_count(10)
		DialogueMange.show_hint("+50未净化水")
