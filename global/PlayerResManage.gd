extends Node

signal inventory_flash

var inventory: Dictionary = {}

func _ready():
	# 初始化库存（排除None）
	var valid_types = DataTypes.Item_Type.values()
	valid_types.erase(DataTypes.Item_Type.None)
	
	for type in valid_types:
		inventory[type] = 0

# 添加物品
func add_item(type: int, amount: int) -> void:
	assert(amount >= 0, "数量不能为负数")
	
	if type == DataTypes.Item_Type.None:
		push_error("类型None无法操作")
		return
	
	if inventory.has(type):
		inventory[type] += amount
	else:
		push_error("无效的物品类型: %s" % type)
	inventory_flash.emit()

# 移除物品
func remove_item(type: int, amount: int) -> bool:
	assert(amount >= 0, "数量不能为负数")
	
	if type == DataTypes.Item_Type.None || !inventory.has(type):
		push_error("无效操作")
		return false
	
	if inventory[type] >= amount:
		inventory[type] -= amount
		return true
	else:
		push_warning("数量不足，无法移除")
		return false

# 查询物品数量
func get_item_count(type: int) -> int:
	if type == DataTypes.Item_Type.None || !inventory.has(type):
		push_error("无效的类型查询")
		return 0
	return inventory[type]

# 强制设置物品数量
func set_item_count(type: int, amount: int) -> void:
	if type == DataTypes.Item_Type.None || !inventory.has(type):
		push_error("无效类型设置")
		return
	inventory[type] = max(0, amount)

# 清空库存
func reset_inventory():
	for type in inventory:
		inventory[type] = 0
