"""
Main Player 
"""

extends Entity
var state_file = preload("PlayerStates.gd")
var direction := Vector2.RIGHT
export var wall_cast_len = 25

var STATES := {
	"WALKING": state_file.Walking.new(),
	"JUMPING": state_file.Jumping.new(),
	"FALLING": state_file.Falling.new(),
}

func _ready() -> void:
	state_machine.init("walk_run", STATES.WALKING.init(self))
	state_machine.add_state("jumping", STATES.JUMPING.init(self))
	state_machine.add_state("falling", STATES.FALLING.init(self))
	_velocity.x = 1

func _physics_process(delta: float):
	state_machine._handle_input()
	state_machine._physics_process_(delta)
	
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	print(_velocity)
	
func jump_high():
	jump(jumping_force * 1.3)

func flip_h(value = false):
	$Sprite.flip_h = value
