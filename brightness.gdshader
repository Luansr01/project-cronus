shader_type canvas_item;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
    COLOR = vec4(vec3(pow(color.r, 2), pow(color.g, 2), pow(color.b, 2)), color.a);
}