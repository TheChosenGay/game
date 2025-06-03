extends Node2D

class_name State

@export var state_name: String = ""
@export var state_machine: StateMachine

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func update(delta: float) -> void:
	pass
	
func physical_update(delta: float) -> void:
	pass
	
signal state_changed(next_state: State)
