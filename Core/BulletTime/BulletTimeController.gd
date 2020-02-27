extends Node
"""
	BulletTimeController Singleton Class Script
"""
signal started
signal ended

var _time_multiplier: =  preload("res://Core/BulletTime/BulletTimeMultiplier.tres") # Forced type inference.

var _remaining_bt: float = 0.0
var _end_signaled: bool = false


func _process(delta: float) -> void:
	
	if _remaining_bt > 0.0:
		_remaining_bt -= delta
		_time_multiplier.multiplier = lerp(
					_time_multiplier.multiplier,
					BulletTimeConfig.MULTIPLIER,
					BulletTimeConfig.LERP_IN_WEIGHT)
	else:
		_time_multiplier.multiplier = lerp(
					_time_multiplier.multiplier,
					BulletTimeConfig.DEFAULT_MULTIPLIER,
					BulletTimeConfig.LERP_OUT_WEIGHT)
	
	if not _end_signaled and is_equal_approx(_remaining_bt, 0.0):
		emit_signal("ended")


func start_bullet_time(duration: float = BulletTimeConfig.DEFAULT_DURATION) -> void:
	# Set remainging to duration if it would be longer
	if _remaining_bt < duration:
		_remaining_bt = duration
		
		_end_signaled = false
		emit_signal("started")
