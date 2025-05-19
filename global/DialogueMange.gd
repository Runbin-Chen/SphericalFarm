extends Node
@onready var interact_panel:InteractPanel = $"/root/MainSurface/UiLayer/Control/MarginContainer/Control/CenteredContent/MidRightResource/InteractPanelContainer"
signal word_pressed(num:int)
#var exist_tile:MeshArea

#func set_tile(tile:MeshArea):
	#if tile.get_child()
# 调试方法（在 _ready() 中添加）


func init_dialogue():
	interact_panel.clear_panel()
	disconnect_all_connections("word_pressed")

func create_dialogue(words:String,num:int):
	interact_panel.add_label(words,num)
	pass


#断开指定对象和信号的所有连接
func disconnect_all_connections(signal_name:String) -> void:
	var connections = self.get_signal_connection_list(signal_name)
	for connection in connections:
		self.disconnect(signal_name, connection["callable"])
