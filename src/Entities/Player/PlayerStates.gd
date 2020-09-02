
class Walking extends State:
	var playback
	var dir := Vector2.ZERO
	
	func init(entity):
		var out = .init(entity)
		return out
	
	func _physics_process_(delta: float) -> void:
		
		_entity.move(dir, delta, _entity.moving_force.ground)
		_entity.decelerate(delta, _entity.friction.ground, -dir.x)
		
	func _handle_input() -> void:
		dir = Vector2.ZERO
		
		if not _entity.is_on_floor():
			_state_machine.travel("falling")
		elif Input.is_action_just_pressed("jump"):
			_state_machine.travel("jumping")
		elif Input.is_action_pressed("move_right"):
			dir.x += Input.get_action_strength("move_right")
			_entity.flip_h(false)
		elif Input.is_action_pressed("move_left"):
			dir.x -= Input.get_action_strength("move_left")
			_entity.flip_h(true)
		elif(abs(_entity._velocity.x) < 2):
			_state_machine.travel("idle")

class Falling extends State:
	var dir := Vector2.ZERO
		
	func _physics_process_(delta: float) -> void:
		_entity.move(dir, delta, _entity.moving_force.air)
		_entity.decelerate(delta, _entity.friction.air)
		
	func _handle_input() -> void:
		dir = Vector2.ZERO
		
		if(_entity.is_on_floor()):
			_state_machine.travel("idle")
		elif Input.is_action_pressed("move_right"):
			dir += Vector2.RIGHT
			_entity.flip_h(false)
		elif Input.is_action_pressed("move_left"):
			dir += Vector2.LEFT
			_entity.flip_h(true)

class Idle extends State:
		
	func _physics_process_(delta: float) -> void:
		_entity.decelerate(delta, _entity.friction.ground)
		
	func _handle_input() -> void:
		if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
			_state_machine.travel("walk_run")
		elif Input.is_action_pressed("jump"):
			_state_machine.travel("jumping")
		elif not _entity.is_on_floor():
			_state_machine.travel("falling")

class Jumping extends State:
	var dir := Vector2.ZERO
		
	func _physics_process_(delta: float) -> void:
		_entity.move(dir, delta, _entity.moving_force.air)
		_entity.decelerate(delta, _entity.friction.air)
		
	func _handle_input() -> void:
		dir = Vector2.ZERO
		
		if Input.is_action_pressed("move_right"):
			dir += Vector2.RIGHT
			_entity.flip_h(false)
		elif Input.is_action_pressed("move_left"):
			dir += Vector2.LEFT
			_entity.flip_h(true)
		
		if(_entity._velocity.y >= 0 and not _entity.is_on_floor()):
			_state_machine.travel("falling")
