shader_type canvas_item;


uniform float percent_visible = .0;

void fragment() {
	COLOR.a = COLOR.a * float(percent_visible >= UV.y);
}
