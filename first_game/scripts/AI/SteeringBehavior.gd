class_name SteeringBehavior extends Node
var seek_behavior: SeekBehavior
var avoid_behavior: AvoidanceBehavior


var steer_context: SteeringBehaviorContext

func _init(context: SteeringBehaviorContext):
	self.steer_context = context
	
	var desired_velocity = context.target_pos - context.origin_pos
	seek_behavior = SeekBehavior.new(desired_velocity, context.current_velocity)
	avoid_behavior = AvoidanceBehavior.new(context.origin_pos, context.target_pos)
	


func calculate_avoidance_force() -> Vector2:
	var avoid_force = Vector2.ZERO
	for obstacle_pos in steer_context.obstacles_pos_arr:
		avoid_force += avoid_behavior.get_steering_force(obstacle_pos)
	return avoid_force


func get_steering_force() -> Vector2:
	var steering_force = seek_behavior.get_steering_force()
	steering_force += self.calculate_avoidance_force()
	return steering_force
	
	
