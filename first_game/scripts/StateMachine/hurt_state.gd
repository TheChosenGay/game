extends State
class_name HurtState

@export var health_comp: HealthComponent
@export var duration: float = 1.0

var delta = 0.0
# hurt state 的优先级很高，可以打断任一状态
var interrupted_state: State
var force_back_position: Vector2

func _ready() -> void:
	health_comp.health_changed.connect(_on_health_changed)
	delta = 0.0
	

func enter() -> void:
	delta = 0.0
	pass
	
func exit() -> void:
	pass
	
	
func update(delta: float) -> void:
	self.delta += delta
	if self.delta > self.duration:
		state_changed.emit(self.interrupted_state)
		return
	var command = Command.new()
	command.state = global.RoleState.Freeze
	command.force_direction = force_back_position
	
	if state_machine:
		state_machine.post_process(command)
	pass
	
func physical_update(delta: float) -> void:
	pass
	
	
func _on_health_changed(attacker_position:Vector2, health_ratio:float):
	force_back_position = (self.global_position - attacker_position).normalized()
	state_changed.emit(self)
	pass
