extends Node
"""
	Boot Autoload Script
	Ensure this is the Last Autoload
"""

const BOOT_SCENE: PackedScene = preload("res://Worlds/FPSTest/FPSTest.tscn")


func _ready() -> void:
	Engine.target_fps = 90 # 90 = all, 120 = HTC VIVE
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	#get_tree().change_scene_to(BOOT_SCENE)
