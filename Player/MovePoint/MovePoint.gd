extends Spatial

export(NodePath) var arvr_origin_path: NodePath
var _arvr_origin: ARVROrigin
export(NodePath) var arvr_head_path: NodePath
var _arvr_head: ARVRCamera

onready var _area: Area = $"Area"
onready var _mesh: MeshInstance = $"Area/MeshInstance"
onready var _ray: RayCast = $"RayCast"

var _colliders: Array = []


func _ready() -> void:
	var n: ARVROrigin = get_node(arvr_origin_path)
	if is_instance_valid(n):
		_arvr_origin = n
	
	var nn: ARVRCamera = get_node(arvr_head_path)
	if is_instance_valid(nn):
		_arvr_head = nn
	
	_area.set_as_toplevel(true)
	_ray.set_as_toplevel(true)


# warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	
	var total_player_rotation: float = _arvr_origin.rotation.y + _arvr_head.rotation.y
	
	# Apply transforms to ray
	_ray.translation = _arvr_head.global_transform.origin
	_ray.translation.y = 1.0
	_ray.rotation.y = total_player_rotation
	
	var distance: float = 5.0
	
	if _ray.is_colliding():
		distance = global_transform.origin.distance_to(_ray.get_collision_point())
	
	distance -= 1.0
	
	# Apply transforms to area
	var area_offset: Vector3 = Vector3(0.0, 0.0, 1.0) * -distance
	area_offset = area_offset.rotated(Vector3.UP, total_player_rotation)
	var area_position: Vector3 = _arvr_head.global_transform.origin + area_offset
	area_position.y = 0.0
	_area.transform.origin = area_position


func can_move_there() -> bool:
	return _colliders.empty()


func get_move_position() -> Vector3:
	return _area.global_transform.origin


func _on_Area_area_entered(area: Area) -> void:
	_colliders.append(area)


func _on_Area_area_exited(area: Area) -> void:
	_colliders.erase(area)


func _on_Area_body_entered(body: Node) -> void:
	_colliders.append(body)


func _on_Area_body_exited(body: Node) -> void:
	_colliders.erase(body)
