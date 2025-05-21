extends Camera3D

var tween: Tween
@export var local_offset := Vector3.ZERO  # 本地坐标系偏移量
#best (0, -20, -50)
signal position_camera(center: Vector3)

func _ready():
	connect("position_camera", _on_position_camera)

func _on_position_camera(center: Vector3):
	if tween != null && tween.is_valid():
		tween.kill()
	
	var normal = center.normalized()
	var distance = 100.0
	var base_target = center + normal * distance
	
	# 新增偏移计算（保持原逻辑不变）
	var look_dir = (center - base_target).normalized()
	var target_basis = Basis.looking_at(look_dir, Vector3.UP)
	var offset_world = target_basis*local_offset
	var target_position = base_target + offset_world
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.tween_method(
		_update_camera_transform,
		Transform3D(global_transform),
		_create_target_transform(center, target_position),
		1.2
	)

func _create_target_transform(center: Vector3, target_pos: Vector3) -> Transform3D:
	var look_dir = (center - target_pos).normalized()
	var basis = Basis.looking_at(look_dir, Vector3.UP)
	return Transform3D(basis, target_pos)

func _update_camera_transform(transform: Transform3D):
	global_transform = transform
	look_at(transform.origin + transform.basis.z * -1, Vector3.UP)
