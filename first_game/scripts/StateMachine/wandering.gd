extends State
class_name WanderingState

@export var agent_ai: AgentAI
@export var next_state: State
@export var cool_down: float = 3

var current_command: Command
var is_refresh_time:bool = false
var timer: Timer

func _ready() -> void:
	set_timer()
	is_refresh_time = true

func enter() -> void:
	timer.start()
	is_refresh_time = true


func exit() ->void:
	timer.stop()
	state_changed.emit(next_state)
	
	
func update(delta: float) ->void:
	var command: Command = current_command
	if is_refresh_time:
		command = get_command()
		current_command = command
		is_refresh_time = false
		timer.start()
	else:
		command = current_command
	$"../../ProgressBar".value += delta
	if state_machine:
		state_machine.post_process(command)
	
func physical_update(delta: float) ->void:
	pass

func get_command() -> Command:
	var command = Command.new()
	command.state  = global.RoleState.Run
	var suggest_dirs = agent_ai.get_suggest_directions()
	var direction = get_direction(suggest_dirs)
	command.direction = direction
	return command
	
func get_direction(dirs: Array[Vector2]) -> global.FaceDirection:
	if dirs.size() > 0:
		var rand = randi() % dirs.size()
		return global.get_face_direction_from(dirs[rand])
	else:
		var rand = randi() % 4
		match rand:
			0: return global.FaceDirection.Left
			1: return global.FaceDirection.Right
			2: return global.FaceDirection.Down
			_: return global.FaceDirection.Up


func set_timer() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = cool_down
	timer.autostart = true
	timer.one_shot = true
	timer.timeout.connect(_on_time_out)
	
func _on_time_out() -> void:
	is_refresh_time = true
	timer.stop()
	$"../../ProgressBar".value = 0
