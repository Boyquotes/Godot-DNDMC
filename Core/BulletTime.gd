extends Node
"""
	BulletTime Autoload Class Script
	Provides Bullet Time functionality for Dashes and other gameplay scenarios
"""

const MAX_BULLET_TIME_USES: int = 3
const USE_RECOVERY_TIME: float = 10.0
const BULLET_TIME_DURATION: float = 2.0
const BULLET_TIME_DURATION_DASH: float = 0.5
const BULLET_TIME_TIME_SCALE: float = 0.5 # 0 - 1

onready var _tween: Tween = _init_tween()

var _remaining_uses: int = 3
var _uses_time: float = 0.0

var _remaining_bullet_time: float = 0.0
var _current_time_scale: float = 1.0


func _init() -> void:
	pass


func _init_tween() -> Tween:
	var n: Tween = Tween.new()
	add_child(n)
	return n


func _process(delta: float) -> void:
	
	delta = correct_delta_timescale(delta)
	
	_advance_uses_timer(delta)
	_advance_bullet_time(delta)


func start_bullet_time() -> void:
	if _remaining_uses > 0:
		_remaining_bullet_time += BULLET_TIME_DURATION
		_remaining_uses -= 1


func start_dash_bullet_time() -> void:
	_remaining_bullet_time += BULLET_TIME_DURATION_DASH


	# Returns delta without timescale manipulation.
func correct_delta_timescale(delta: float) -> float:
	return delta * (1 + (1.0 - _current_time_scale))


func _advance_uses_timer(delta: float) -> void:
	if not _remaining_uses >= MAX_BULLET_TIME_USES:
		_uses_time += correct_delta_timescale(delta)
		
		if _uses_time >= USE_RECOVERY_TIME:
			_remaining_uses += 1
			_uses_time = 0.0


func _advance_bullet_time(delta: float) -> void:
	# BT is on
	if _remaining_bullet_time > 0.0:
		_remaining_bullet_time -= correct_delta_timescale(delta)
		
		_current_time_scale = lerp(_current_time_scale, BULLET_TIME_TIME_SCALE, 0.25)
	
	else:
		_current_time_scale = lerp(_current_time_scale, 1.0, 0.25)
	
	# Only edit timescale when different. To avoid potential wierdness. May not be needed.
	if not is_equal_approx(Engine.time_scale, _current_time_scale):
		Engine.time_scale = _current_time_scale
