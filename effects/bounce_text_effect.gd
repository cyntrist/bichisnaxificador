extends RichTextEffect
class_name BounceTextEffect

var bbcode = "bounce"
# ESTO NO FUNCIONA!!!!!!!!!!!!!!!!!!!!!!!!
func _process_custom_fx(char_fx):
	var t = char_fx.elapsed_time
	var delay = char_fx.relative_index * 0.03
	if t < delay:
		return true
	var local_t = t - delay
	var bounce = sin(local_t * 18.0) * exp(-local_t * 6.0)
	char_fx.offset.y -= bounce * 12.0
	return true