shader_type canvas_item;

uniform bool is_flashing;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	if(is_flashing == true){
    	COLOR = vec4(1, 1, 1, color.a);
	}else{
		COLOR = color;
	}

}