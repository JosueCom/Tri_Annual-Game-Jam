class_name StateMachine

var _states := {}
var _current_state

func init(id: String, current_state):
	add_state(id, current_state)
	_current_state = current_state
	_current_state._enter()

func travel(id: String):
	_current_state._exit()
	_current_state = _states[id]
	_current_state._enter()
	
func add_state(id: String, state):
	_states[id] = state
	
func remove_state(id: String):
	return _states.erase(id)

func _physics_process_(delta: float) -> void:
	_current_state._physics_process_(delta)

func _handle_input():
	_current_state._handle_input()
