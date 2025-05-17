extends Node2D
class_name AttackComponent
	
func attack(body: HealthComponent):
	var attack_context = create_attack_context()
	body.get_attack(attack_context)

func create_attack_context():
	var attack_context = AttackContext.new()
	attack_context.damage = 100
	attack_context.is_fall_back = false
	return attack_context
