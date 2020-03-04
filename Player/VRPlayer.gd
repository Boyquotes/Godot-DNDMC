extends ARVROrigin

onready var _head: ARVRCamera = $"Head"
onready var _left_hand: ARVRController = $"LeftHand"
onready var _right_hand: ARVRController = $"RightHand"
onready var _move_point: Area = $"MovePoint"
onready var _tween: Tween = $"Tween"

var _is_moving: bool = false
var _is_rotating: bool = false


func _ready() -> void:
	# warning-ignore:return_value_discarded
	UserOptions.connect("option_changed", self, "_on_useroptions_option_changed")

# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_useroptions_option_changed(category: String, option: String, value) -> void:
	pass


func _process(delta: float) -> void:
	if _right_hand.is_trackpad_pressed():
		var pos: Vector2 = _right_hand.trackpad_position
		
		if abs(pos.x) > 0.4:
			var dir: int = 1 if pos.x < 0 else -1
			rotation.y += TAU * dir * delta


func _on_InputHandler_move_action_requested() -> void:
	if _is_moving:
		return
	
	var global_target_pos: Vector3 = _move_point.get_move_position()
	global_target_pos.y = 0.0
	DebugPoints.add_position_green(global_target_pos)
	
	_tween.interpolate_property(
			self, "global_transform:origin",
			global_transform.origin, global_target_pos,
			0.2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	_tween.start()
	_is_moving = true


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if not object == self:
		return
	
	if key == NodePath(":global_transform:origin"):
		_is_moving = false
