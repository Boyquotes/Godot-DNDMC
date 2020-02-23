extends State


	# Called to confirm validity of Entering this State
func i_can_enter(machine, new_owner: Object) -> bool:
	return true


	# Called by StateMachine immediatly after Entering this State.
func i_enter_state() -> void:
	pass


	# Called every Frame by StateMachine
func i_advance(delta: float) -> void:
	pass


	# Called every Input by StateMachine
func i_input(input_event: InputEvent) -> void:
	if input_event.is_action_pressed("ui_accept"):
		print("okokokok")


	# Called by StateMachine immediatly before Entering this State.
func i_exit_state() -> void:
	pass
