extends Node3D
var Grass:Node3D

const BUSH_1 = preload("res://assets/import_model/sketchfab/greenhouse_foliage/scenes/bush_1.tscn")
const BUSH_2 = preload("res://assets/import_model/sketchfab/greenhouse_foliage/scenes/bush_2.tscn")
const GRASS_1 = preload("res://assets/import_model/sketchfab/greenhouse_foliage/scenes/grass_1.tscn")
const GRASS_2 = preload("res://assets/import_model/sketchfab/greenhouse_foliage/scenes/grass_2.tscn")

func _ready():
	Grass = Node3D.new()
	self.add_child(Grass)
	randomize()  # 初始化随机种子
	generate_grass()
	
func generate_grass()->void:
	var scenes = [BUSH_1, BUSH_2, GRASS_1, GRASS_2]
	
	# 生成10个实例（数量可调）
	for i in 10:
		var instance = scenes.pick_random().instantiate()
		instance.position = Vector3(
			randf_range(-0.5, 0.5), 
			0, 
			randf_range(-0.5, 0.5)
		)
		instance.rotation.y = randf() * TAU  # 随机Y轴旋转（0-360度）
		instance.scale = Vector3(0.2, 0.2, 0.2)  # 缩小到原来的0.5倍
		Grass.add_child(instance)



func selected():
	DialogueMange.init_dialogue()
	disp_dialogue()
	DialogueMange.word_pressed.connect(_on_button_pressed)

func disp_dialogue():
	if Grass.get_children():
		DialogueMange.create_dialogue("除草（-10行动点 +10种子）",1)
	else:
		DialogueMange.hide_panel()

func _on_button_pressed(num:int):
	if (num == 1):
		PlayerResManage.add_item(DataTypes.Item_Type.Seed,10)
		TimeManage.plus_count(10)
		DialogueMange.show_hint("+10种子")
		for child in Grass.get_children():
			child.queue_free()
		DialogueMange.hide_panel()
