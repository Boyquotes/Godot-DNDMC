extends Resource
class_name BulletTimeMultiplier

export(float, 0.0, 2.0) var multiplier: float = BulletTimeConfig.DEFAULT_MULTIPLIER setget set_multiplier


func set_multiplier(new_value: float) -> void:
	multiplier = clamp(new_value, 0.0, 2.0)
