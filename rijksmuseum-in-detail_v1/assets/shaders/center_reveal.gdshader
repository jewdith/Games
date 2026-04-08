shader_type canvas_item;

uniform float reveal_radius : hint_range(0.0, 1.0) = 0.0;
uniform vec2 reveal_center = vec2(0.5, 0.5);

void fragment() {
	vec2 uv_centered = UV - reveal_center;
    float dist = max(abs(uv_centered.x), abs(uv_centered.y));
    float alpha = smoothstep(reveal_radius, reveal_radius - 0.02, dist);
    COLOR = texture(TEXTURE, UV) * alpha;
}