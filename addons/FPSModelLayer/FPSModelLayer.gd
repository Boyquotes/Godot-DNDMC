extends CanvasLayer
"""
	FPSModelLayer Singleton Scene Script
	Used to Display Weapon models in First person, using a different FOV.
"""

var fps_viewport: Viewport setget set_fps_viewport

onready var _texturerect: TextureRect = $TextureRect


func set_fps_viewport(new_value: Viewport) -> void:
	if is_instance_valid(new_value):
		fps_viewport = new_value
		_texturerect.texture = fps_viewport.get_texture()


func _on_TextureRect_resized() -> void:
	if is_instance_valid(fps_viewport):
		fps_viewport.size = _texturerect.rect_size
