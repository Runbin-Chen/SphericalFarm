class_name InteractLabel
extends PanelContainer
@onready var words_label: Label = $"VBoxContainer/Words Label"
var id:int

func _on_words_label_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			DialogueMange.word_pressed.emit(id)
			# 执行你的逻辑

func set_label(words:String,num:int):
	id = num
	words_label.text = words
