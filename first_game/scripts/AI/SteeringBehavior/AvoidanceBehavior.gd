class_name AvoidanceBehavior extends Node

var origin_pos: Vector2
var target_pos: Vector2

func _init(origin_pos: Vector2, target_pos: Vector2) -> void:
	self.origin_pos = origin_pos
	self.target_pos = target_pos

func get_steering_force(obstacle_pos: Vector2) -> Vector2:
	# 计算斜率
	var ratio = float(origin_pos.x - obstacle_pos.x) / ( obstacle_pos.y - origin_pos.y)
	var avoid_dir1 = origin_pos + Vector2(1.0, ratio)
	var avoid_dir2 = origin_pos + Vector2(1.0, -ratio)
	
	var desired_dir = target_pos - origin_pos
	
	var avoid_force = avoid_dir1
	if avoid_dir1.dot(desired_dir) < avoid_dir2.dot(desired_dir):
		avoid_force = avoid_dir2
	
	var avoid_factor = desired_dir.length() - 64.0
	avoid_factor *= avoid_factor
	avoid_factor = 100.0 / avoid_factor
	
	avoid_force = avoid_force.normalized() * avoid_factor
	return avoid_force
	
