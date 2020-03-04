extends Node
"""
	Boot Autoload Script
	Ensure this is the Last Autoload and that the ARVR Player has loaded first.
"""

const BOOT_SCENE: PackedScene = preload("res://Worlds/Test/Test.tscn")


func _ready() -> void:
	
	VRViewport.start_vr()
	
	# warning-ignore:return_value_discarded
	get_tree().change_scene_to(BOOT_SCENE)
