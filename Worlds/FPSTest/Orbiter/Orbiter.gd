extends Spatial

export(bool) var correct_delta: bool = false

func _process(delta: float) -> void:
	
	if correct_delta:
		delta = BulletTime.correct_delta_timescale(delta)
	
	print(delta)
	
	rotation.y += delta * 4
