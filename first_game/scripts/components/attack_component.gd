extends Node2D
class_name AttackComponent

var damage: int = 100
	
func attack(body: HealthComponent):
	var attack_context = create_attack_context()
	body.get_attack(attack_context)

func create_attack_context():
	var attack_context = AttackContext.new()
	attack_context.damage = damage
	attack_context.is_fall_back = false
	attack_context.attacker_position = self.global_position
	return attack_context
