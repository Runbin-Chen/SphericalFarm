extends Camera3D

var tween: Tween	# 用于存储当前动画实例
# 定义信号，参数为面的中心点坐标
signal position_camera(center: Vector3)

func _ready():
	# 将信号连接到处理函数，或在其他节点触发时连接
	connect("position_camera", _on_position_camera)

# 处理信号，调整摄像机位置和朝向
func _on_position_camera(center: Vector3):
	if tween != null && tween.is_valid():
		tween.kill()
	
	# 计算目标参数
	var normal = center.normalized()
	var distance = 100.0
	var target_position = center + normal * distance
	var initial_position = global_position
	
	# 创建统一动画控制器
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_ease(Tween.EASE_OUT)
	
	# 使用tween_method同步控制位置和旋转
	tween.tween_method(
		_update_camera_transform,  # 自定义更新方法
		Transform3D(global_transform),  # 初始状态
		_create_target_transform(center, target_position),  # 目标状态
		1.2  # 总时长
	)

# 生成目标变换矩阵
func _create_target_transform(center: Vector3, target_pos: Vector3) -> Transform3D:
	var look_dir = (center - target_pos).normalized()
	var basis = Basis.looking_at(look_dir, Vector3.UP)
	return Transform3D(basis, target_pos)

# 每帧更新摄像机状态
func _update_camera_transform(transform: Transform3D):
	global_transform = transform
	look_at(transform.origin + transform.basis.z * -1, Vector3.UP)  # 强制修正朝向
