extends Node2D

class_name MoveComponent

# 目前MoveComponent只支持四向移动

@export var acceleration: Vector2 = Vector2.ZERO
@export var speed: float = 100
@export var jump_speed: float = 50
@export var role: CharacterBody2D

var command: Command
var velocity: Vector2 = Vector2.ZERO

enum MoveType {
	LinearMove,
	AcceMove
}

var move_type: MoveType = MoveType.LinearMove

func linear_move_with(command: Command):
	move_with(command, MoveType.LinearMove)

func move_with(command: Command, move_type: MoveType):
	var direction = get_direction_from(command)
	match command.state:
		global.RoleState.Idle:
			move(Vector2.ZERO, move_type)
		global.RoleState.Run:
			move(direction * speed, move_type)
		global.RoleState.Attack:
			move(Vector2.ZERO,move_type)
		global.RoleState.Jump:
			move(Vector2.UP * jump_speed, move_type)

func move(velocity: Vector2, move_type: MoveType):
	self.move_type = move_type
	self.velocity = velocity
	role.velocity = get_velocity_by_move_type()
	role.move_and_slide()
	
# === 
# === 辅助函数
# ===

func get_velocity_by_move_type() -> Vector2:
	if self.move_type == MoveType.LinearMove:
		return self.velocity
	else:
		return Vector2.ZERO

func get_direction_from(command: Command):
	match command.direction:
		global.FaceDirection.Left:
			return Vector2.LEFT
		global.FaceDirection.Right:
			return Vector2.RIGHT
		global.FaceDirection.Down:
			return Vector2.DOWN
		_:
			return Vector2.UP
			
