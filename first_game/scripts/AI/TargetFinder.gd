extends Node2D
@export var detector:Detector

var target: Node2D
var last_visible_position: Vector2
var relationEngine: RelationshipEngine


# ============= public methods begin

func get_desired_position() -> Vector2:
	return last_visible_position
	
func has_target() -> bool:
	return target != null

# ============= public methods end


func _ready() -> void:
	detector._item_entered.connect(_on_item_entered)
	relationEngine = RelationshipEngine.new(global.ItemType.Enemy)

func _process(delta: float) -> void:
	self.update_last_visible_position()
	
func update_last_visible_position():
	if self.is_target_visible(target):
		last_visible_position = target.position

func is_target_visible(body: Node2D) -> bool:
	var target_dir = body.position - position
	var result = check_hit_in_direction(position, target_dir, detector.detect_radius)
	if result.hit && result.collider == body:
		return true;
	return false

func check_hit_in_direction(from_position: Vector2, dir: Vector2, max_radius:float) -> Dictionary:
	var ray = RayCast2D.new()
	ray.position = from_position
	ray.target_position = dir.normalized() * max_radius
	ray.collision_mask = 1
	
	ray.force_raycast_update()
	var result = {
		"hit": false,
		"collider": null,
		"collision_position": Vector2.ZERO,
		"collision_normal": Vector2.ZERO,
	}
	
	if ray.is_colliding():
		result.hit = true
		result.collider = ray.get_collider()
		result.collision_position = ray.get_collision_point()
		result.colision_normal = ray.get_collision_normal()
	
	return result


func _on_item_entered(body:Node2D):
	if !target && body.has("type") \
		&& relationEngine.get_relationship_of(body.tyep):
		target = body

# 受伤时，改变仇恨目标
func _on_hurt(body:Node2D):
	if body.has("type")\
	&& relationEngine.get_relationship_of(body.type):
		target = body
