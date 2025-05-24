extends Resource
class_name BaseUpdateStrategy

@export var texture: Texture = preload("res://assets/Fruits Asset/02.png")
@export var label:  String

func update_move(move_component: MoveComponent):
	pass
	
func update_attack(attack_component: AttackComponent):
	pass

func update_role(role: Sprite2D):
	pass
