shader_type canvas_item;

uniform float reveal_radius : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    vec2 uv_centered = UV - vec2(0.5);
    float dist = length(uv_centered);
    float alpha = step(dist, reveal_radius); // visible inside radius
    COLOR = texture(TEXTURE, UV) * alpha;
}