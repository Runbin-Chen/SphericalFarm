extends Node
@onready var interact_panel:InteractPanel = $"/root/MainSurface/UiLayer/Control/MarginContainer/Control/CenteredContent/MidRightResource/InteractPanelContainer"
@onready var UiLayer:CanvasLayer = $"/root/MainSurface/UiLayer"
signal word_pressed(num:int)
#var exist_tile:MeshArea

#func set_tile(tile:MeshArea):
	#if tile.get_child()
# 调试方法（在 _ready() 中添加）


func init_dialogue():
	interact_panel.clear_panel()
	disconnect_all_connections("word_pressed")

func hide_panel():
	interact_panel.hide_panel()


func create_dialogue(words:String,num:int):
	interact_panel.add_label(words,num)
	pass


#断开指定对象和信号的所有连接
func disconnect_all_connections(signal_name:String) -> void:
	var connections = self.get_signal_connection_list(signal_name)
	for connection in connections:
		self.disconnect(signal_name, connection["callable"])



func show_hint(hint_text: String):
	# 动态创建Label
	var label = Label.new()
	label.text = hint_text
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	# 设置字体样式（可选）
	var font = load("res://assets/font/SourceHanSansCN-Normal.otf") # 如果有自定义字体
	if font:
		label.add_theme_font_override("font", font)
	label.add_theme_font_size_override("font_size", 16)
	label.modulate = Color.WHITE
	
	# 添加到场景
	UiLayer.add_child(label)
	
	# 获取视口尺寸
	var viewport = get_viewport().get_visible_rect()
	var screen_height = viewport.size.y
	
	# 设置初始位置（屏幕底部之外）
	label.position = Vector2(
		viewport.size.x / 2 - label.size.x / 2,  # 水平居中
		screen_height*0.6  # 底部之外
	)
	
	# 创建Tween动画
	var tween = create_tween().set_parallel(true)
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
	# Y轴移动动画（2秒）
	tween.tween_property(label, "position:y", screen_height*0.4, 2.0)
	# 透明度动画（2秒）
	tween.tween_property(label, "modulate:a", 0.0, 2.0)
	
	# 动画完成后移除Label
	tween.chain().tween_callback(label.queue_free)

#func _ready():
	#show_hint("这是动态创建的提示！")
