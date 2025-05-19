class_name InteractPanel
extends MarginContainer
@onready var box_container: VBoxContainer = $VBoxContainer
const InteractLabelScene = preload("res://scenes/UI/InteractPanel/interact_label.tscn")

func clear_panel():
	get_parent().visible = true
	for child in box_container.get_children():
		child.queue_free()  # 安全释放节点

func hide_panel():
	get_parent().visible = false

func add_label(words:String,num:int):
	var new_label:InteractLabel = InteractLabelScene.instantiate()
	new_label.name="interact_label_panel%02d"%num
	box_container.add_child(new_label)
	new_label.set_label(words,num)
	pass
