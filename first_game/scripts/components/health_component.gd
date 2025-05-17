extends Node2D
class_name HealthComponent
@export var health: int = 400
@export var role: Node2D
func get_attack(attack: AttackContext):
	health -= attack.damage
	print("health = ", health)
	if health <= 0:
		print("died")
		role.queue_free()
		
