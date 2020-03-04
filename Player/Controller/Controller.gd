extends ARVRController

signal trigger_pressed(event)
signal menu_pressed(event)
signal trackpad_pressed(event, position)
signal grip_pressed(event)

var trackpad_position: Vector2 = Vector2()

var _device_id: int

var _trigger_pressed: bool = false
var _menu_pressed: bool = false
var _trackpad_pressed: bool = false
var _grip_pressed: bool = false


func _ready() -> void:
	add_to_group("VRControllers")


func _unhandled_input(event: InputEvent) -> void:
	if not event.device == _device_id:
		return
	
	if event.is_action("vive_trigger"):
		_trigger_pressed = event.pressed
		emit_signal("trigger_pressed", event)
		
	if event.is_action("vive_menu"):
		_menu_pressed = event.pressed
		emit_signal("menu_pressed", event)
		
	if event.is_action("vive_trackpad"):
		_trackpad_pressed = event.pressed
		emit_signal("trackpad_pressed", event, trackpad_position)
		
	if event.is_action("vive_grip"):
		_grip_pressed = event.pressed
		emit_signal("grip_pressed", event)


func _process(delta: float) -> void:
	var new_trackpad_position: Vector2 = Vector2()
	new_trackpad_position.x = get_joystick_axis(0)
	new_trackpad_position.y = get_joystick_axis(1)
	trackpad_position = new_trackpad_position


func is_trigger_pressed() -> bool:
	return _trigger_pressed


func is_menu_pressed() -> bool:
	return _menu_pressed


func is_trackpad_pressed() -> bool:
	return _trackpad_pressed


func is_grip_pressed() -> bool:
	return _grip_pressed


func _group_initialize_device_id() -> void:
	_device_id = get_joystick_id()
	print("Initialized ARVRController %s as device_id %s" % [name, _device_id])
