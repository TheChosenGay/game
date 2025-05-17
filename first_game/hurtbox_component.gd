extends Area2D
class_name HurtboxComponent
@export var health: HealthComponent

func _ready() -> void:
	self.collision_layer = global.MONITOR_HURT_LAYER
