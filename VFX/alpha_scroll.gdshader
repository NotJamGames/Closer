shader_type canvas_item;


uniform float x_percent_visible = .0;
uniform float y_percent_visible = .0;

void fragment() {
	COLOR.a = COLOR.a 
			* float(x_percent_visible >= UV.x)
			* float(y_percent_visible >= UV.y);
}
