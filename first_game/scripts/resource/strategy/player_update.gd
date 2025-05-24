extends Area2D

@export var update_strategy: BaseUpdateStrategy

@onready var label: Label = $Label
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	label.text = update_strategy.label
	sprite.texture = update_strategy.texture
	
func _on_body_entered(body: CollisionObject2D):
	if body is Player:
		for child in get_all_children(body):
			if child is MoveComponent:
				update_strategy.update_move(child)
			if child is AttackComponent:
				update_strategy.update_attack(child)
		
			if child is Sprite2D and update_strategy is RingVFXStrategy:
				update_strategy.update_role(child)
				
		self.queue_free()
		
		
		# 递归获取所有子节点的函数
func get_all_children(node):
	var result = []
	for child in node.get_children():
		result.append(child)
		result += get_all_children(child)
	return result
