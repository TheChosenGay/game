extends ProgressBar
class_name HealthBar

@export var health:HealthComponent

func _ready() -> void:
	max_value = 1.0
	value = 1.0
	health.connect("health_changed", _on_health_changed)
	
	
func _on_health_changed(attacker_position: Vector2, health_ratio: float) -> void:
	var tween = create_tween()
	tween.tween_property(self, "value", health_ratio, 0.1)
