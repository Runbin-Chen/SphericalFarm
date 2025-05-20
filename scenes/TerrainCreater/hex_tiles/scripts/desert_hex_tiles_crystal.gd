extends Node3D

func selected():
	DialogueMange.init_dialogue()
	disp_dialogue()
	DialogueMange.word_pressed.connect(_on_button_pressed)

func disp_dialogue():
	DialogueMange.create_dialogue("采矿（-10行动点 随机获得矿砂）",1)

func _on_button_pressed(num:int):
	if (num == 1):
		TimeManage.plus_count(10)
		var SteelDust_num=PlayerResManage.get_probability_item(50,20)
		DialogueMange.show_hint("石头+20")
		await get_tree().create_timer(0.25).timeout
		DialogueMange.show_hint("矿砂+%d"%SteelDust_num)
		PlayerResManage.add_item(DataTypes.Item_Type.Stone,20)
		PlayerResManage.add_item(DataTypes.Item_Type.SteelDust,SteelDust_num)
