extends OmniLight3D

var radius: float
var tween: Tween  # 同步动画控制器
var last_angle:float = 0.0

func _ready():
	# 计算初始半径（XZ平面到原点的距离）
	var pos = global_position
	radius = sqrt(pos.x ** 2 + pos.z ** 2)
	TimeManage.connect("time_flash", _on_time_flash)
	last_angle = 0
	set_orbit_angle(0)

func set_orbit_angle(angle_deg: float):
	# 将度数转换为弧度
	var angle_rad = deg_to_rad(angle_deg)
	# 计算新位置
	var x = radius * cos(angle_rad)
	var z = radius * sin(angle_rad)
	# 更新全局位置，保持Y轴不变
	global_position = Vector3(x, global_position.y, z)
	# 使光源朝向原点
	look_at(Vector3.ZERO, Vector3.UP)

func _on_time_flash(day: int, count: int) -> void:
	# 先停止已有动画
	if tween != null && tween.is_valid():
		tween.kill()
	
	# 计算目标角度（保持当前角度作为起始值）
	#var target_angle = 360.0 / TimeManage.turn_per_day * count
	var target_angle =  360.0 / TimeManage.turn_per_day * count + 360*day
	var current_angle = last_angle
	last_angle = target_angle
	
	#test use
	print("data:")
	print(current_angle)
	print(target_angle)
	
	# 创建与摄像机同步的动画参数
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_ease(Tween.EASE_OUT)
	
	# 使用角度插值动画
	tween.tween_method(_update_light_angle, current_angle, target_angle, 1.2)

func _update_light_angle(angle_deg: float):
	# 复用原有位置计算逻辑
	var angle_rad = deg_to_rad(angle_deg)
	var x = radius * cos(angle_rad)
	var z = radius * sin(angle_rad)
	global_position = Vector3(x, global_position.y, z)
	look_at(Vector3.ZERO, Vector3.UP)
