extends BaseUpdateStrategy
class_name SpeedUpdateStratey
@export var speed: int = 1000

func _ready() -> void:
	label  = "Speed"

func update_move(component: MoveComponent):
	component.speed += speed
