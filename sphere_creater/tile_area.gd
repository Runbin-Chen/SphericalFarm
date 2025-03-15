class_name MeshArea
extends Area3D
@export var thickness: float = 0.5

@export var center = [] #中点
@export var adjust_vertices = [] #调整后的点数组
@export var id:int
@export var neighbors_id = []


func _ready() -> void:
	collision_layer = 1
	monitoring = true
	input_event.connect(_on_click)

func _on_click(cam, event, pos, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("凸包碰撞体触发成功")
		print(id)
		print(neighbors_id)
		#print(center)
		

func init(chunk_id:int)->void:
	id = chunk_id
	self.name="TileArea" + str(id)

# 通过此方法动态设置碰撞形状
func set_shape(mesh: Mesh) -> void:
	var arr = mesh.surface_get_arrays(0)
	var vertices = arr[ArrayMesh.ARRAY_VERTEX]
	center=vertices[0]
	if vertices.size() == 6:
		adjust_vertices.append(vertices[3])
		adjust_vertices.append(vertices[4])
		adjust_vertices.append(vertices[5])
		adjust_vertices.append(vertices[2])
		adjust_vertices.append(vertices[1])
	else:
		adjust_vertices.append(vertices[3])
		adjust_vertices.append(vertices[4])
		adjust_vertices.append(vertices[5])
		adjust_vertices.append(vertices[6])
		adjust_vertices.append(vertices[2])
		adjust_vertices.append(vertices[1])
	var new_mesh:ArrayMesh=generate_extruded_mesh(adjust_vertices,2)
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.name = "GeneratedMesh"  # 可选：给节点命名
	add_child(mesh_instance)
	mesh_instance.mesh = new_mesh
	configure_material(mesh_instance)
	
	var collision_shape = CollisionShape3D.new()
	collision_shape.shape = new_mesh.create_convex_shape()  # Godot 4.0+关键API
	add_child(collision_shape)

func generate_extruded_mesh(vertices: Array, height: float) -> ArrayMesh:
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	# 计算底面法线
	var normal = compute_normal(vertices)
	var top_vertices = vertices.duplicate()
	for i in range(top_vertices.size()):
		top_vertices[i] += normal * height
		top_vertices[i] = center + (top_vertices[i] - center) * 0.8
	
	# 添加底面顶点
	for v in vertices:
		st.add_vertex(v)
	
	# 添加顶面顶点（逆序以确保法线方向正确）
	var top_start = vertices.size()
	for i in range(top_vertices.size() - 1, -1, -1):
		st.add_vertex(top_vertices[i])
	
	# 底面三角剖分（扇式）
	var bottom_vert_count = vertices.size()
	for i in range(1, bottom_vert_count - 1):
		st.add_index(0)
		st.add_index(i)
		st.add_index((i + 1) % bottom_vert_count)
	
	# 顶面三角剖分（扇式，起始点为top_start）
	var top_tri_count = top_vertices.size() - 2
	for i in range(top_tri_count):
		st.add_index(top_start)
		st.add_index(top_start + i + 1)
		st.add_index(top_start + (i + 2) % (top_vertices.size()))
	
	# 侧面四边形处理
	for i in range(vertices.size()):
		var current = i
		var next = (i + 1) % vertices.size()
		var top_current = top_start + (vertices.size() - 1 - i)
		var top_next = top_start + (vertices.size() - 1 - next)
		
		# 第一个三角形：current -> next -> top_next
		st.add_index(current)
		st.add_index(top_next)
		st.add_index(next)
		
		# 第二个三角形：current -> top_next -> top_current
		st.add_index(current)
		st.add_index(top_current)
		st.add_index(top_next)
		
	
	# 自动生成法线
	st.generate_normals()
	return st.commit()

func compute_normal(vertices: Array) -> Vector3:
	if vertices.size() < 3:
		return Vector3.UP
	var v0 = vertices[0]
	var v1 = vertices[1]
	var v2 = vertices[2]
	var vec1 = v1 - v0
	var vec2 = v2 - v0
	return vec1.cross(vec2).normalized()


# 辅助函数：配置材质
func configure_material(mesh: MeshInstance3D) -> void:
	mesh.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	# 创建新材质或复制现有材质
	var mat: StandardMaterial3D = StandardMaterial3D.new()
	
	# 设置材质属性
	mat.albedo_color = Color("ffd5be")  # 基础颜色（红色）
	mat.metallic = 0                      # 金属度
	mat.roughness = 0.8               # 粗糙度
	
	
	# 应用材质到网格
	mesh.material_override = mat
