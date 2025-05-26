shader_type canvas_item;
uniform vec4 flash_color: source_color = vec4(1.0, 0.2, 0.2, 1.0);
uniform float mix_factor:hint_range(0.0, 1.0, 0.1) = 0.7;

void fragment() {
	vec4 origin_color = texture(TEXTURE, UV);
	if (origin_color.a < 0.5)
		discard;
	COLOR = mix(origin_color, flash_color, 1.0 - mix_factor);
}