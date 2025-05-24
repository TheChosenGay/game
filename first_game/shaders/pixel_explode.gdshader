shader_type canvas_item;

uniform int hframes = 4;
uniform int vframes = 4;


vec2 convertToLocalUV(vec2 coord) {
	float width = 1.0 / float(hframes);
	float height = 1.0 / float(vframes);
	int hIdx = int(coord.x / width);
	int vIdx = int(coord.y / height);
	vec2 uv = vec2((coord.x - float(hIdx) * width) / width,
				 (coord.y - float(vIdx) * height)/height);
	return uv;
}

// 控制参数
uniform float progress : hint_range(0, 1) = 0.0; // 爆炸进度(0-1)
uniform float pixel_size : hint_range(1, 64) = 16.0; // 像素块大小
uniform vec2 direction = vec2(0.0, -1.0); // 爆炸方向
uniform float randomness : hint_range(0, 1) = 0.5; // 随机性强度
uniform float rotation_speed : hint_range(0, 10) = 2.0; // 旋转速度

// 伪随机函数
float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	vec2 localUV = convertToLocalUV(UV);
    // 计算像素化UV
    vec2 pixelated_uv = floor(localUV * pixel_size) / pixel_size;
    
    // 获取原始颜色
    vec4 color = texture(TEXTURE, pixelated_uv);
    
    // 为每个像素块生成随机种子
    float seed = rand(pixelated_uv);
    
    // 计算爆炸位移
    float explosion_factor = max(0.0, progress - seed * randomness);
    vec2 explosion_offset = direction * explosion_factor * explosion_factor * 10.0;
    
    // 添加随机偏移
    explosion_offset += vec2(
        rand(pixelated_uv.yx) - 0.5,
        rand(pixelated_uv.xy) - 0.5
    ) * randomness * explosion_factor * 2.0;
    
    // 计算旋转角度
    float rotation = explosion_factor * rotation_speed * (seed * 2.0 - 1.0);
    float sin_rot = sin(rotation);
    float cos_rot = cos(rotation);
    
    // 获取相对于像素块中心的UV
    vec2 centered_uv = (localUV - pixelated_uv) - vec2(0.5);
    
    // 手动应用旋转矩阵
    vec2 rotated_uv;
    rotated_uv.x = cos_rot * centered_uv.x - sin_rot * centered_uv.y;
    rotated_uv.y = sin_rot * centered_uv.x + cos_rot * centered_uv.y;
    
    // 应用变换
    vec2 final_uv = rotated_uv + vec2(0.5) + pixelated_uv + explosion_offset;
    
    // 采样最终颜色
    vec4 final_color = texture(TEXTURE, final_uv);
    
    // 根据进度淡出
    final_color.a *= smoothstep(1.0, 0.8, explosion_factor);
    
    COLOR = final_color;
}