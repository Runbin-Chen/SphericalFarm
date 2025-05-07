extends OmniLight3D

var radius: float

func _ready():
	# 计算初始半径（XZ平面到原点的距离）
	var pos = global_position
	radius = sqrt(pos.x ** 2 + pos.z ** 2)
	TimeManage.connect("time_flash",_on_time_flash)
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

func _on_time_flash(day:int,count:int)->void:
	set_orbit_angle(360/12*count)
