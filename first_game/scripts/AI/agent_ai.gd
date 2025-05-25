extends Node2D
class_name AgentAI

var raycast_arr: Array[RayCast2D] = []
var interest_arr: Array[float] = []
var damage_arr: Array[float] = []


# 游戏AI追逐的角色
@export var target_role: Node2D 
@export var damage_factor:float = 5
@export var target_detect_distance: float = 300
@export var damage_detect_distance: float = 200


func _ready()->void:
	set_all_ray_casts()
	reset()
	
func get_suggest_directions() -> Array[Vector2]:
	calculate_context_arr()
	# 这个地方的策略可以做成可配置的
	var suggest_dirs: Array[Vector2] = []
	for idx in range(interest_arr.size()):
		if interest_arr[idx] < 0:
			continue
		suggest_dirs.append(raycast_arr[idx].target_position.normalized())
	# 重置所有数组
	reset()
	return suggest_dirs
	
func is_valid_direction(direction: Vector2) -> bool:
	match direction:
		Vector2.LEFT, Vector2.RIGHT, Vector2.DOWN, Vector2.UP:
			return true
		_: 
			return false

func set_all_ray_casts() -> void:
	for child in get_children():
		if child is RayCast2D:
			child.target_position = child.target_position.normalized() * damage_detect_distance
			raycast_arr.append(child)


func is_colliding() -> bool:
	for raycast in raycast_arr:
		if raycast.is_colliding():
			return true
	return false

func calculate_damage_arr() -> void:
	for idx in range(raycast_arr.size()):
		if raycast_arr[idx].is_colliding() \
			and not (raycast_arr[idx].get_collider() == target_role):
			damage_arr[idx] = damage_factor

func reset() -> void:
	damage_arr.resize(raycast_arr.size())
	damage_arr.fill(0)
	interest_arr.resize(raycast_arr.size())
	interest_arr.fill(0)
	


func calculate_interest_arr() -> void:
	if !target_role:
		return
		
	var target_dir = target_role.position - position
	if target_dir.length() > target_detect_distance:
		return
		
	var target_norm_dir = target_dir.normalized()
	for idx in range(raycast_arr.size()):
		interest_arr[idx] = raycast_arr[idx].target_position.normalized() * target_norm_dir

# 为了节省空间，我们直接用interest array作为context 数组
func calculate_context_arr() -> void:
	calculate_interest_arr()
	calculate_damage_arr()
	
	assert(interest_arr.size() == damage_arr.size(),
		 "the size of intert array not equals to damage array")
		
	for idx in interest_arr.size():
		interest_arr[idx] -= damage_arr[idx]
