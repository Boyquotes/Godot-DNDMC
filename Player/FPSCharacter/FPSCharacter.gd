extends KinematicBody

export(float, 0.0, 100.0) var speed: float = 10.0
export(float, -100.0, 100.0) var gravity: float = -5.0

onready var _head: Spatial = $"FPSHead"


func _physics_process(delta: float) -> void:
	var direction: Vector3 = Vector3()
	direction += Vector3.FORWARD * Input.get_action_strength("move_forward")
	direction += Vector3.BACK * Input.get_action_strength("move_back")
	direction += Vector3.LEFT * Input.get_action_strength("move_left")
	direction += Vector3.RIGHT * Input.get_action_strength("move_right")
	
	direction = direction.rotated(Vector3.UP, _head.direction)
	
	var velocity = direction * speed
	
	velocity -= Vector3.DOWN * gravity
	
	move_and_slide_with_snap(velocity, Vector3.DOWN, Vector3.UP, true, 4, 0.78)
