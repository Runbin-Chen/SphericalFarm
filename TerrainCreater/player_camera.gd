extends Camera3D

# 定义信号，参数为面的中心点坐标
signal position_camera(center: Vector3)

func _ready():
	# 将信号连接到处理函数，或在其他节点触发时连接
	connect("position_camera", _on_position_camera)

# 处理信号，调整摄像机位置和朝向
func _on_position_camera(center: Vector3):
	# 获取法线方向（原点到中心点的单位向量）
	var normal = center.normalized()
	# 设置距离，可根据需要调整
	var distance = 100.0
	# 计算摄像机位置：中心点 + 法线方向 × 距离
	var camera_position = center + normal * distance
	# 更新全局位置
	global_transform.origin = camera_position
	# 让摄像机看向中心点
	look_at(center)
