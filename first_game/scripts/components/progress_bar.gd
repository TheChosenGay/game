extends ProgressBar

func _ready() -> void:
	max_value = 1.0
	value = 1.0

func _on_health_component_health_changed(health_ratio: float) -> void:
	var tween = create_tween()
	tween.tween_property(self, "value", health_ratio, 0.2)
