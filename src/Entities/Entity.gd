
class_name Entity
extends KinematicBody2D

export (float) var gravity = ProjectSettings.get("physics/2d/default_gravity")
export (float) var mass = 1.0
export (Dictionary) var moving_force = {
	"ground": 370,
	"air": 320
}
export (Dictionary) var friction = {
	"ground": 250,
	"air": 150
}
export (float) var jumping_force = 210.0
export (Vector2) var terminal_speed = Vector2(100.0, 500.0)

const FLOOR_NORMAL = Vector2.UP

var _velocity := Vector2.ZERO
var state_machine := StateMachine.new()

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	
	_velocity.y = clamp(_velocity.y, -terminal_speed.y, terminal_speed.y)
	_velocity.x = clamp(_velocity.x, -terminal_speed.x, terminal_speed.x)

func move(direction, delta, force = moving_force.ground):
	_velocity += (force/mass) * direction * delta
	
func jump(force = jumping_force):
	move(Vector2.UP, 1, force)

func decelerate(delta, force = friction.ground, direction = null):
	var dir
	
	if direction:
		dir = direction
	else:
		dir = -sign(_velocity.x)
		
	if abs(_velocity.x) < 3:
		_velocity.x = lerp(_velocity.x, 0, 0.9)
	else:
		move(Vector2(dir, 0), delta, force)
