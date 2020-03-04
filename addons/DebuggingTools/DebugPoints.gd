extends Node

var _mesh_green: SphereMesh = SphereMesh.new()
var _mesh_yellow: SphereMesh = SphereMesh.new()
var _mesh_red: SphereMesh = SphereMesh.new()
var _material_green: SpatialMaterial = SpatialMaterial.new()
var _material_yellow: SpatialMaterial = SpatialMaterial.new()
var _material_red: SpatialMaterial = SpatialMaterial.new()


func _init() -> void:
	_mesh_green.material = _material_green
	_mesh_green.radius = 0.05
	_mesh_green.height = 0.1
	_material_green.albedo_color = Color.green
	_material_green.flags_unshaded = true
	
	_mesh_yellow.material = _material_red
	_mesh_yellow.radius = 0.05
	_mesh_yellow.height = 0.1
	_material_yellow.albedo_color = Color.yellow
	_material_yellow.flags_unshaded = true
	
	_mesh_red.material = _material_red
	_mesh_red.radius = 0.05
	_mesh_red.height = 0.1
	_material_red.albedo_color = Color.red
	_material_red.flags_unshaded = true


func add_position_green(global_position: Vector3) -> void:
	var n: TempMeshInstance = TempMeshInstance.new()
	n.mesh = _mesh_green
	add_child(n)
	n.global_transform.origin = global_position


func add_position_yellow(global_position: Vector3) -> void:
	var n: TempMeshInstance = TempMeshInstance.new()
	n.mesh = _mesh_yellow
	add_child(n)
	n.global_transform.origin = global_position


func add_position_red(global_position: Vector3) -> void:
	var n: TempMeshInstance = TempMeshInstance.new()
	n.mesh = _mesh_red
	add_child(n)
	n.global_transform.origin = global_position


class TempMeshInstance:
	extends MeshInstance
	
	func _ready() -> void:
		yield(get_tree().create_timer(5.0), "timeout")
		queue_free()

