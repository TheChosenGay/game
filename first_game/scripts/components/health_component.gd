extends Node2D
class_name HealthComponent
@export var max_health: int = 400
@export var role: Node2D
var health: int

func _ready() -> void:
	health = max_health
	
func get_attack(attack: AttackContext):
	health -= attack.damage
	health_changed.emit(attack.attacker_position, health / float(max_health))
	if health <= 0:
		died.emit()
		role.queue_free()
		


signal health_changed(attacer_position:Vector2, health_ratio: float)
signal died
