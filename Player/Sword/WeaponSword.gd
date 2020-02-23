extends Spatial

var _state_machine: StateMachine = _init_state_machine()


func _init_state_machine() -> StateMachine:
	var n: StateCollection = StateCollection.new()
	
	n.add_state("idle", preload("res://Player/Sword/States/Idle.gd").new())
	
	return StateMachine.new(self, n)


func _unhandled_input(event: InputEvent) -> void:
	_state_machine.advance_state_input(event)


func _process(delta: float) -> void:
	_state_machine.advance_state_delta(delta)