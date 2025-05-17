extends Node2D

@export var move_component: MoveComponent
@export var anim_component: AnimationComponent
@export var use_input_command: bool = false

var last_facing_direction: global.FaceDirection = global.FaceDirection.Left

func _input(event):
	if not use_input_command:
		return;
	if event is InputEventKey:
		# 键盘按下/释放时更新速度
		var is_pressed = event.pressed

		var command = Command.new()
		if !is_pressed:
			command.state = global.RoleState.Idle
			command.direction = last_facing_direction
		else:
			command.state = global.RoleState.Run
			match event.keycode:
				KEY_W, KEY_UP:
					command.direction = global.FaceDirection.Up
				KEY_S, KEY_DOWN:
					command.direction = global.FaceDirection.Down
				KEY_A, KEY_LEFT:
					command.direction = global.FaceDirection.Left
				KEY_D, KEY_RIGHT:
					command.direction = global.FaceDirection.Right
				KEY_F:
					command.state = global.RoleState.Attack
					command.direction = last_facing_direction
					
		last_facing_direction = command.direction
	
		
		if anim_component:
			anim_component.animate(command)

		if move_component:
			move_component.linear_move_with(command)

func _process(delta: float) -> void:
	if use_input_command:
		return
		
	var command = Command.new()
	if not Input.is_anything_pressed():
		command.state = global.RoleState.Idle
		command.direction = last_facing_direction
	else:
		command.state = global.RoleState.Run
		if Input.is_action_pressed("turn_left"):
			command.direction = global.FaceDirection.Left
		elif Input.is_action_pressed("turn_right"):
			command.direction = global.FaceDirection.Right
		elif Input.is_action_pressed("turn_down"):
			command.direction = global.FaceDirection.Down
		elif Input.is_action_pressed("turn_up"):
			command.direction = global.FaceDirection.Up
		elif Input.is_action_pressed("attack"):
			command.state = global.RoleState.Attack
			command.direction = last_facing_direction
		else:
			command.state = global.RoleState.Idle
			command.direction = last_facing_direction
	
	last_facing_direction = command.direction
	
	if move_component:
		move_component.linear_move_with(command)
	
	if anim_component:
		anim_component.animate(command)
