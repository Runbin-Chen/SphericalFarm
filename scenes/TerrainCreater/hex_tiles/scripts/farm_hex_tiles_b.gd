extends Node3D
#@onready var corn_plant: CornPlant = $CornPlant
var crop_plant : PlantBase
const CornPlant_scence = preload("res://scenes/TerrainCreater/hex_tiles/farm_system/corn_plant.tscn")
const TomatoPlant_scence = preload("res://scenes/TerrainCreater/hex_tiles/farm_system/tomato_plant.tscn")

func _ready() -> void:
	PlayerResManage.add_item(DataTypes.Item_Type.Seed,100)

func selected():
	DialogueMange.init_dialogue()
	disp_dialogue()
	DialogueMange.word_pressed.connect(_on_button_pressed)

func disp_dialogue():
	var crop_plant = get_node("CropPlant")
	if !crop_plant:
		DialogueMange.create_dialogue("种植",1)
	else:
		if crop_plant.state == crop_plant.Growth_Type.Harvest:
			DialogueMange.create_dialogue("采收",2)
		else:
			DialogueMange.create_dialogue("生长中",3)
		

func _on_button_pressed(num:int):
	crop_plant = get_node("CropPlant")
	if (num == 1):
		DialogueMange.clear_panel()
		DialogueMange.create_dialogue("种植玉米",11)
		DialogueMange.create_dialogue("种植西红柿",12)
	
	if (num == 11 or num == 12):
		if (PlayerResManage.get_item_count(DataTypes.Item_Type.Seed)<10):
			DialogueMange.show_hint("种子不足")
		else:
			if crop_plant:
				DialogueMange.show_hint("已种植")
			else:
				if num == 11:
					crop_plant = CornPlant_scence.instantiate()
				else:
					crop_plant = TomatoPlant_scence.instantiate()
				add_child(crop_plant)
				crop_plant.name = "CropPlant"
				PlayerResManage.remove_item(DataTypes.Item_Type.Seed,10)
				crop_plant.init_plant()
				DialogueMange.show_hint("种植成功")
				DialogueMange.clear_panel()
				DialogueMange.create_dialogue("生长中",3)
	if (num == 2 ):
		var numbers = crop_plant.harvest()
		PlayerResManage.add_item(crop_plant.get_crop_type(),numbers)
		DialogueMange.show_hint(crop_plant.get_crop_name()+"+%d"%numbers)
		await get_tree().create_timer(0.25).timeout
		var seed_num:int = numbers/2
		DialogueMange.show_hint("种子+%d"%seed_num)
		PlayerResManage.add_item(DataTypes.Item_Type.Seed,seed_num)
		get_node("CropPlant").queue_free()
		DialogueMange.clear_panel()
		DialogueMange.create_dialogue("种植",1)
		#disp_dialogue()
			
	#if (num == 1):
		#if (PlayerResManage.get_item_count(DataTypes.Item_Type.Seed)<10):
			#DialogueMange.show_hint("种子不足")
		#else:
			#if corn_plant.state != corn_plant.Growth_Type.None:
				#DialogueMange.show_hint("已种植")
			#else:
				#PlayerResManage.remove_item(DataTypes.Item_Type.Seed,10)
				#corn_plant.init_plant()
				#DialogueMange.show_hint("种植成功")
				#TimeManage.plus_count(2)
	#if (num == 3):
		#var numbers = corn_plant.harvest()
		#PlayerResManage.add_item(DataTypes.Item_Type.Corn,numbers)
		#DialogueMange.show_hint("玉米+%d"%numbers)
		#await get_tree().create_timer(0.25).timeout
		#var seed_num:int = numbers/2
		#DialogueMange.show_hint("种子+%d"%seed_num)
		#PlayerResManage.add_item(DataTypes.Item_Type.Seed,seed_num)
		
		
