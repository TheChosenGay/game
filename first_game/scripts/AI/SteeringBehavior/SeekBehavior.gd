class_name SeekBehavior extends Node

var desired_velocity: Vector2
var current_velocity: Vector2

func _init(desired_velocity: Vector2, current_velocity: Vector2) -> void:
	self.desired_velocity = desired_velocity
	self.current_velocity = current_velocity

func get_steering_force() -> Vector2:
	return (desired_velocity - current_velocity).normalized() * current_velocity.length() / 3.0
