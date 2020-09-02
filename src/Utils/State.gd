class_name State

var _state_machine
var _entity

func init(entity):
	_entity = entity
	_state_machine = entity.state_machine
	return self

func _enter() -> void:
	pass
	
func _physics_process_(_delta: float) -> void:
	pass
	
func _handle_input() -> void:
	pass
	
func _exit() -> void:
	pass
