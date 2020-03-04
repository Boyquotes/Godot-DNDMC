extends Node

signal move_action_requested


func _on_LeftHand_trackpad_pressed(event: InputEvent, position: Vector2) -> void:
	emit_signal("move_action_requested")
