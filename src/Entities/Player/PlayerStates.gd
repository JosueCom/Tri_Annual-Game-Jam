
class Walking extends State:
	var playback
	
	func init(entity):
		var out = .init(entity)
		return out
	
	func _enter() -> void:
		_entity.get_node("WetSpot").emitting = true
	
	func _physics_process_(delta: float) -> void:
		
		_entity.move(_entity.direction, delta, _entity.moving_force.ground)
		
	func _handle_input() -> void:
		
		if not _entity.is_on_floor():
			_state_machine.travel("falling")
		elif Input.is_action_just_pressed("jump"):
			_state_machine.travel("jumping")

	func _exit() -> void:
		_entity.get_node("WetSpot").emitting = false

class Falling extends State:

	func _physics_process_(delta: float) -> void:
		_entity.move(_entity.direction, delta, _entity.moving_force.air)
		
	func _handle_input() -> void:
		if(_entity.is_on_floor()):
			_state_machine.travel("walk_run")
		elif Input.is_action_just_pressed("jump") and _entity.is_on_wall():
			_state_machine.travel("jumping")

class Jumping extends State:
	var dir := Vector2.ZERO

	func init(entity):
		var out = .init(entity)
		return out

	func _enter() -> void:
		if _entity.is_on_wall() and not _entity.is_on_floor():
			_entity.flip_h(not _entity.get_node("Sprite").flip_h)
			_entity.direction *= -1
		_entity._velocity.y = -700
		
	func _physics_process_(delta: float) -> void:
		_entity.move(_entity.direction, delta, _entity.moving_force.air)
		
	func _handle_input() -> void:
		if(_entity._velocity.y >= 0 and not _entity.is_on_floor()):
			_state_machine.travel("falling")
		elif Input.is_action_just_pressed("jump") and _entity.is_on_wall():
			_state_machine.travel("jumping")
