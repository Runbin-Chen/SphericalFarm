extends Node3D

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var collision_shape_3d: CollisionShape3D = $Area3D/CollisionShape3D



func set_shape(mesh:Mesh)->void:
	mesh_instance_3d.mesh = mesh
	var aabb = mesh_instance_3d.get_aabb()
	var box_shape = BoxShape3D.new()
	box_shape.size = aabb.size
	collision_shape_3d.shape = box_shape
	
