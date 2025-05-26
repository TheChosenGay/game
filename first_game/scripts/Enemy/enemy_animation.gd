extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var move_component: MoveComponent = $"../MoveComponent"

var timer: Timer
func _on_health_component_health_changed(health_ratio: float) -> void:
	set_timer()
	animation_player.stop()
	for child in get_children():
		if child is Sprite2D:
			apply_hurt_effect(child)
	
	

func set_timer():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 10
	timer.one_shot = true
	timer.timeout.connect(on_time_out)
	timer.start()
	
	
func apply_hurt_effect(sprite: Sprite2D) -> void:
	var shader_material = ShaderMaterial.new()
	shader_material.shader = load("res://shaders/hurt_vfx.gdshader")
	shader_material.set_shader_parameter("shader_parameter/mix_factor", 0.3)
	sprite.material = shader_material

func on_time_out():
	animation_player.play()
	for child in get_children():
		if child is Sprite2D:
			child.material = null
	
