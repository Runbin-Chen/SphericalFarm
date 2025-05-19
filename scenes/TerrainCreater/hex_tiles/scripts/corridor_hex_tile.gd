extends Node3D

func selected():
	DialogueMange.init_dialogue()
	disp_dialogue()
	DialogueMange.word_pressed.connect(_on_button_pressed)

func disp_dialogue():
	DialogueMange.create_dialogue("睡眠（+100行动点 消耗10回合）",1)
	DialogueMange.create_dialogue("提炼矿石 （10块 消耗10行动点）",2)

func _on_button_pressed(num:int):
	if (num == 1):
		#PlayerResManage.add_item(DataTypes.Item_Type.Wood,50)
		TimeManage.plus_count(10)
	if (num == 2):
		PlayerResManage.add_item(DataTypes.Item_Type.Steel,10)
		TimeManage.plus_count(10)
