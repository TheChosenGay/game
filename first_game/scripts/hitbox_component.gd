extends Area2D
class_name HitboxComponent

@export var attacker: AttackComponent

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	self.collision_mask = global.MONITOR_HURT_LAYER
	self.collision_layer = global.PLAYER_HIT_LAYER
	
	
func _on_area_entered(hurtbox: HurtboxComponent):
	if hurtbox.health:
		attacker.attack(hurtbox.health)
