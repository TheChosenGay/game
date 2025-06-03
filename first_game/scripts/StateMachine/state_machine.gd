extends Node2D
class_name StateMachine

var state_dict: Dictionary={}

# 如果不设置初始状态，默认使用第一个状态为初始化状态
@export var current_state: State
@export var move_component: MoveComponent
@export var anim_component: AnimationComponent

func _ready() -> void:
	for child in get_children():
		# 如果child不是state或者child已经注册了，那就直接跳过
		if child is not State:
			continue
		var state := child as State
		assert(not state_dict.has(state.state_name), 
			"state: " + state.state_name + " already exists!!" )
		if !current_state:
			current_state = state
		# 注册state和通知
		state_dict[state.state_name] = state
		state.state_changed.connect(_on_state_changed)


func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
		
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physical_update(delta)

func _on_state_changed(next_state: State) -> void:
	if !next_state or next_state == current_state:
		return
	current_state.exit()
	# 对hurt state做处理，后续可以考虑更好的方案
	if next_state is HurtState:
		next_state.interrupted_state = current_state
	current_state = next_state
	current_state.enter()
	
# state 共用的后处理，要被state调用
func post_process(command: Command):
	if move_component:
		move_component.linear_move_with(command)
	if anim_component:
		anim_component.animate(command)
