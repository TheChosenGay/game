//shader_type canvas_item;
//
//uniform vec4 color : source_color = vec4(0.0, 0.8, 1.0, 1.0);
//uniform float inner_radius : hint_range(0.0, 1.0) = 0.4;
//uniform float outer_radius : hint_range(0.0, 1.0) = 0.5;
//uniform float intensity : hint_range(0.0, 10.0) = 1.0;
//uniform float pulse_speed : hint_range(0.0, 5.0) = 1.0;
//
//void fragment() {
    //// 计算从中心到当前像素的距离(归一化到0-1)
    //vec2 center = UV - vec2(0.5);
    //float dist = length(center) * 2.0; // 乘以2使直径=1
    //
    //// 添加脉冲效果(可选)
    //float pulse = sin(TIME * pulse_speed) * 0.05;
    //float effective_inner = inner_radius + pulse;
    //float effective_outer = outer_radius + pulse;
    //
    //// 正确的光环强度计算
    //// 使用smoothstep创建平滑过渡
    //float halo = smoothstep(effective_inner, effective_outer, dist);
    //// 反转并再次平滑，创建环状效果
    //halo *= 1.0 - smoothstep(effective_outer, effective_outer + 0.05, dist);
    //
    //// 应用颜色和强度
    //COLOR = color * halo * intensity;
    //
    //// 与原始纹理混合(如果有)
  //
    //vec4 tex = texture(TEXTURE, UV);
    //COLOR = mix(tex, COLOR, halo);
    //
//}
shader_type canvas_item;

uniform float sensitivity = 1.0;
uniform vec4 edge_color : source_color = vec4(0.0, 1.0, 1.0, 1.0); // 青色边缘

void fragment() {
    vec4 center = texture(TEXTURE, UV);
    
    // 只处理角色部分(不透明区域)
    if (center.a > 0.0) {
        // 获取周围像素
        vec4 top = texture(TEXTURE, UV + sensitivity * vec2(0.0,  TEXTURE_PIXEL_SIZE.y));
        vec4 bottom = texture(TEXTURE, UV + sensitivity * vec2(0.0, - TEXTURE_PIXEL_SIZE.y));
        vec4 left = texture(TEXTURE, UV + sensitivity * vec2(- TEXTURE_PIXEL_SIZE.x, 0.0));
        vec4 right = texture(TEXTURE, UV + sensitivity * vec2(TEXTURE_PIXEL_SIZE.x, 0.0));
		float alpha = top.a * bottom.a * left.a * right.a;
        if (alpha > 0.0) {
			COLOR = center;
		} else {
			 COLOR = edge_color;
		}
       
    }
}