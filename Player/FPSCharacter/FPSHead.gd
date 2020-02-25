tool
extends Spatial
"""
	FPSCharacter Head Script
"""

export(float) var head_height: float = 1.8 setget set_head_height
export(float) var max_vertical_angle: float = 85.0 setget set_max_vertical_angle

const MIN_HEAD_HEIGHT: float = 1.2
const MAX_HEAD_HEIGHT: float = 2.2

var direction: float = 0.0 # For external use.

var _max_vertical_angle_rad: float = 0.0
var _mouse_sensitivity: float = 0.0


func set_head_height(new_value: float) -> void:
	head_height = clamp(new_value, MIN_HEAD_HEIGHT, MAX_HEAD_HEIGHT)
	transform.origin.y = head_height


func set_max_vertical_angle(new_value: float) -> void:
	max_vertical_angle = clamp(new_value, 0.0, 90.0)
	_max_vertical_angle_rad = deg2rad(max_vertical_angle)


func _ready() -> void:
	if Engine.editor_hint:
		set_process_unhandled_input(false)
	
	UserOptions.connect("option_changed", self, "_on_useroptions_option_changed")
	
	set_max_vertical_angle(max_vertical_angle)
	
	FPSModelLayer.fps_viewport = $"Viewport"


func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventMouseMotion:
		return
	
	var motion: Vector2 = event.relative
	
	var new_x: float = rotation.x - (motion.y * _mouse_sensitivity)
	rotation.x = clamp(new_x, -_max_vertical_angle_rad, _max_vertical_angle_rad)
	
	rotation.y -= motion.x * _mouse_sensitivity
	
	direction = rotation.y


static func _map_mouse_sensitivity(value: float) -> float:
	return range_lerp(value, 0.0, 1.0, 0.0, 0.01)


func _on_useroptions_option_changed(category: String, option: String, value) -> void:
	if category == UserOptionsConstants.CONTROLS and option == UserOptionsConstants.CONTROLS_MOUSE_SENSITIVITY:
		_mouse_sensitivity = _map_mouse_sensitivity(value)
