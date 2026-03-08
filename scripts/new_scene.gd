extends Scene

@onready var exit_button : TextureButton = $Exit
var tween_hover : Tween
var tween_click : Tween
var hover_scale = Vector2(1.1, 1.1)
var default_scale = Vector2(1.0, 1.0)
var tween_hover_duration = 0.2

func on_enable() -> void:
	var tween2 = create_tween()
	tween2.set_trans(Tween.TRANS_SINE)
	tween2.set_ease(Tween.EASE_IN_OUT)
	tween2.tween_property(exit_button, "modulate", Color(1,1,1,0.5), 1.0)
	pass
	
func on_disable() -> void:
	pass

func _on_exit_mouse_entered() -> void:
	tween_hover = create_tween()
	tween_hover.set_trans(Tween.TRANS_SINE)
	tween_hover.set_ease(Tween.EASE_OUT)
	tween_hover.parallel().tween_property(exit_button, "scale", hover_scale, tween_hover_duration)
	tween_hover.parallel().tween_property(exit_button, "modulate", Color(1,1,1,1), tween_hover_duration)
	pass # Replace with function body.


func _on_exit_mouse_exited() -> void:
	tween_hover = create_tween()
	tween_hover.set_trans(Tween.TRANS_SINE)
	tween_hover.set_ease(Tween.EASE_OUT)
	tween_hover.parallel().tween_property(exit_button, "scale", default_scale, tween_hover_duration)
	tween_hover.parallel().tween_property(exit_button, "modulate", Color(1,1,1,0.5), tween_hover_duration)
	pass # Replace with function body.


func _on_exit_button_down() -> void:
	if tween_click: 
		tween_click.kill()
	if tween_hover:
		tween_hover.kill()
	exit_button.scale = Vector2(0.9, 0.9)
	pass # Replace with function body.



func _on_exit_button_up() -> void:
	tween_click = create_tween()
	tween_click.set_ease(Tween.EASE_OUT)
	tween_click.set_trans(Tween.TRANS_SPRING)
	tween_click.tween_property(exit_button, "scale", Vector2(1,1), 0.25)
	Global.change_scene(Global.Scenes.MENU)
	pass # Replace with function body.

