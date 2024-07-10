shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	float gray = dot(texture_color.rgb, vec3(0.299, 0.587, 0.114));
	COLOR.rgb = vec3(gray);
	COLOR.a = texture_color.a;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
