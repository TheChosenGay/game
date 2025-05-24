extends BaseUpdateStrategy
class_name AttackUpdateStrategy

@export var damage: int = 20

func _ready() -> void:
	label = "Attack"

func update_attack(component: AttackComponent):
	component.damage += damage
