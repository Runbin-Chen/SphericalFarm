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
		if (PlayerResManage.get_item_count(DataTypes.Item_Type.SteelDust)>=100):
			PlayerResManage.remove_item(DataTypes.Item_Type.SteelDust,100)
			PlayerResManage.add_item(DataTypes.Item_Type.Steel,10)
			TimeManage.plus_count(10)
			DialogueMange.show_hint("矿砂-100")
			await get_tree().create_timer(0.25).timeout
			DialogueMange.show_hint("铁锭+10")
		else:
			DialogueMange.show_hint("没有足够矿砂")
