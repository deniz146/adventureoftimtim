shader_type canvas_item;

uniform float blur_size : hint_range(0.0, 20.0) = 5.0;

void fragment() {
    vec2 size = vec2(textureSize(TEXTURE, 0));
    vec2 texcoord = UV;
    vec4 color = vec4(0.0);
    
    int samples = 10;
    float total_weight = 0.0;

    for (int i = -samples; i <= samples; i++) {
        for (int j = -samples; j <= samples; j++) {
            float weight = 1.0 - length(vec2(float(i), float(j))) / float(samples);
            color += texture(TEXTURE, texcoord + vec2(float(i), float(j)) * blur_size / size) * weight;
            total_weight += weight;
        }
    }

    color /= total_weight;
    COLOR = color;
}
