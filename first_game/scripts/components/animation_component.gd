extends Node2D

class_name AnimationComponent

@export var animation_player: AnimationPlayer
@export var animation_folder: String
	
func animate(command: Command):
	var animation_name = animation_folder + "/" + get_animation_name_with(command)
	# print("animation_name = ", animation_name)
	if animation_player.has_animation(animation_name):
		animation_player.play(animation_name)

func get_animation_name_with(command: Command):
	var prefix_name = get_prefix_animation_name(command)
	var posfix_name = get_posfix_animation_name(command)
	return prefix_name + "_" + posfix_name

func get_prefix_animation_name(command: Command):
	match command.state:
		global.RoleState.Idle:
			return "idle"
		global.RoleState.Run:
			return "run"
		global.RoleState.Attack:
			return "attack"
		global.RoleState.Jump:
			return "jump"

func get_posfix_animation_name(command: Command):
	match command.direction:
		global.FaceDirection.Left:
			return "left"
		global.FaceDirection.Right:
			return "right"
		global.FaceDirection.Up:
			return "up"
		global.FaceDirection.Down:
			return "down"
