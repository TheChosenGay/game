extends BaseUpdateStrategy
class_name RingVFXStrategy

@export var shaderMaterial: ShaderMaterial

func update_role(role: Sprite2D):
	# 创建材质副本， 必须，不同的sprite要有单独的shaderMaterial
	var shader_material = shaderMaterial.duplicate()
	shader_material.set_shader_parameter("hframes", role.hframes)
	shader_material.set_shader_parameter("vframes", role.vframes)
	role.material = shader_material
