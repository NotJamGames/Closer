shader_type canvas_item;

uniform float outer_radius : hint_range(0.0, 5.0) = 1.0;
uniform float main_alpha : hint_range(0.0, 1.0) = 1.0;


void fragment() {
	float x = abs(UV.x - .5) * 2.0;
	float y = abs(UV.y - .5) * 2.0;
	float v = (sqrt((x * x) + (y * y)) / outer_radius);
	COLOR = vec4(0, 0, 0, v * main_alpha);
}