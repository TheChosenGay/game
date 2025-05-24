shader_type canvas_item;
uniform int hframes = 4;
uniform int vframes = 4;

//// 可调参数
//uniform float thickness : hint_range(0, 0.5) = 0.01;
//uniform float smoothness : hint_range(0, 1) = 0.01;
//uniform vec4 color : source_color = vec4(1.0, 0.8, 0.3, 1.0); // 金色光环
//uniform float speed : hint_range(0, 5) = 1.0; // 动画速度
//uniform float radius = 0.3;

vec2 convertToLocalUV(vec2 coord) {
	float width = 1.0 / float(hframes);
	float height = 1.0 / float(vframes);
	int hIdx = int(coord.x / width);
	int vIdx = int(coord.y / height);
	vec2 uv = vec2((coord.x - float(hIdx) * width) / width,
				 (coord.y - float(vIdx) * height)/height);
	return uv;
}

//void fragment() {
	//vec2 localUV = convertToLocalUV(UV);
	 //// 计算从中心到当前像素的距离
    //vec2 center = vec2(0.5, 0.5);
    //float dist = distance(localUV, center);
    //
    //// 添加脉动动画
    //float pulse = sin(TIME * speed) * 0.03;
    //float outer_radius = radius + pulse;
    //float inner_radius = outer_radius - thickness;
    //
    //// 计算光环强度
    //float halo = smoothstep(inner_radius - smoothness, inner_radius, dist) * 
                //(1.0 - smoothstep(outer_radius, outer_radius + smoothness, dist));
    //vec4 origin_color = texture(TEXTURE, UV);
    //// 应用颜色
    //COLOR = mix(origin_color, vec4(color.rgb, color.a * halo), halo);
	//
//}


uniform vec4 color : source_color = vec4(0.0, 0.8, 1.0, 1.0);
uniform float inner_radius : hint_range(0.0, 1.0) = 0.4;
uniform float outer_radius : hint_range(0.0, 1.0) = 0.5;
uniform float intensity : hint_range(0.0, 10.0) = 1.0;
uniform float pulse_speed : hint_range(0.0, 5.0) = 1.0;

void fragment() {
    // 计算从中心到当前像素的距离(归一化到0-1)
	vec2 localUV = convertToLocalUV(UV);
    vec2 center = localUV - vec2(0.5);
    float dist = length(center) * 2.0; // 乘以2使直径=1
    
    // 添加脉冲效果(可选)
    float pulse = sin(TIME * pulse_speed) * 0.05;
    float effective_inner = inner_radius + pulse;
    float effective_outer = outer_radius + pulse;
    
    // 正确的光环强度计算
    // 使用smoothstep创建平滑过渡
    float halo = smoothstep(effective_inner, effective_outer, dist);
    // 反转并再次平滑，创建环状效果
    halo *= 1.0 - smoothstep(effective_outer, effective_outer + 0.05, dist);
    
    // 应用颜色和强度
    COLOR = color * halo * intensity;
    
    // 与原始纹理混合(如果有)
  
    vec4 tex = texture(TEXTURE, UV);
    COLOR = mix(tex, COLOR, halo);
    
}




