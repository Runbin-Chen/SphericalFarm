extends Camera3D

# 旋转参数
var angle: float = 0.0
var radius: float = 200.0
var angular_speed: float = 1.0  # 弧度/秒（默认约57度/秒）

func _process(delta: float) -> void:
	# 更新角度
	angle += angular_speed * delta
	
	# 计算新位置（极坐标转笛卡尔坐标）
	var new_position = Vector3(
		radius * sin(angle),  # X轴位置
		0.0,                  # 保持Y轴为0
		radius * cos(angle)   # Z轴位置
	)
	
	# 更新摄像机位置和朝向
	position = new_position
	look_at(Vector3.ZERO, Vector3.UP)  # 始终看向原点
