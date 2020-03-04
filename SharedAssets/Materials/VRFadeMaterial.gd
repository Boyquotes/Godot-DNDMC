extends SpatialMaterial
class_name VRMaterial


func _init() -> void:
	params_diffuse_mode = SpatialMaterial.DIFFUSE_TOON
	params_specular_mode = SpatialMaterial.SPECULAR_TOON
	params_depth_draw_mode = SpatialMaterial.DEPTH_DRAW_ALWAYS
	
	
	distance_fade_mode = SpatialMaterial.DISTANCE_FADE_PIXEL_ALPHA
	distance_fade_min_distance = 0.1
	distance_fade_max_distance = 0.25
