shader_type canvas_item;

// thanks to: https://www.youtube.com/watch?v=32jdNLTJ3zY

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform vec4 water_color : source_color;

void fragment() {
	vec4 water = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR.rgb = mix(water.rgb, water_color.rgb, water_color.a);
}
