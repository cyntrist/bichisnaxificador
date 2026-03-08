extends Scene

@onready var logo_letras = $Logo/Logo
@onready var logo_fondo = $Logo/Fondo
@onready var boton_nuevo = $Botones/Nuevo
@onready var boton_aleatorio = $Botones/Aleatorio

@export var tween_speed : float = 1.0
@export var tween_trans : Tween.TransitionType = Tween.TRANS_SPRING
@export var tween_ease : Tween.EaseType = Tween.EASE_OUT

var tween_logo_bg : Tween
var tween_logo_letras : Tween
var tween_boton_aleatorio : Tween
var tween_boton_nuevo : Tween

var tween_logo_click1:Tween
var tween_logo_click2:Tween

var tween_hover : Tween
var hover_scale = Vector2(1.1, 1.1)
var default_scale = Vector2(1.0, 1.0)
var tween_hover_duration = 0.2

func _init() -> void:
	pass

func _draw() -> void:
	pass

func _ready() -> void:
	pass

func on_enable() -> void:
	if tween_logo_letras:
		tween_logo_letras.kill()
	tween_logo_letras = create_tween()
	tween_logo_letras.set_ease(tween_ease)
	tween_logo_letras.set_trans(tween_trans)
	tween_logo_letras.tween_property(logo_letras, "position:y", 140, tween_speed)
	
	await Global.timer(0.2)
	if tween_logo_bg: 
		tween_logo_bg.kill()
	tween_logo_bg = create_tween()
	tween_logo_bg.set_ease(tween_ease)
	tween_logo_bg.set_trans(tween_trans)
	tween_logo_bg.tween_property(logo_fondo, "position:y", 100, tween_speed)
	
	await Global.timer(0.2)
	if tween_boton_aleatorio: 
		tween_boton_aleatorio.kill()
	tween_boton_aleatorio = create_tween()
	tween_boton_aleatorio.set_ease(tween_ease)
	tween_boton_aleatorio.set_trans(tween_trans)
	tween_boton_aleatorio.tween_property(boton_aleatorio, "position:y", 355, tween_speed)

	await Global.timer(0.2)
	if tween_boton_nuevo: 
		tween_boton_nuevo.kill()
	tween_boton_nuevo = create_tween()
	tween_boton_nuevo.set_ease(tween_ease)
	tween_boton_nuevo.set_trans(tween_trans)
	tween_boton_nuevo.tween_property(boton_nuevo, "position:y", 355, tween_speed)
	pass

func on_disable() -> void:
	pass
	

func _on_boton_button_down() -> void:
	if tween_logo_click1: 
		tween_logo_click1.kill()
	if tween_logo_click2: 
		tween_logo_click2.kill()
	$Logo/Fondo.scale = Vector2(0.9, 0.9)
	$Logo/Logo.scale = Vector2(0.9, 0.9)
	pass # Replace with function body.


func _on_boton_button_up() -> void:
	tween_logo_click1 = create_tween()
	tween_logo_click1.set_ease(Tween.EASE_OUT)
	tween_logo_click1.set_trans(Tween.TRANS_SPRING)
	tween_logo_click1.tween_property($Logo/Fondo, "scale", Vector2(1,1), 0.25)
	
	await Global.timer(0.1)
	tween_logo_click2 = create_tween()
	tween_logo_click2.set_ease(Tween.EASE_OUT)
	tween_logo_click2.set_trans(Tween.TRANS_SPRING)
	tween_logo_click2.tween_property($Logo/Logo, "scale", Vector2(1,1), 0.25)
	pass # Replace with function body.


func _on_aleatorio_mouse_entered() -> void:
#	if tween_hover:
#		tween_hover.kill()
	tween_hover = create_tween()
	tween_hover.set_trans(Tween.TRANS_SINE)
	tween_hover.set_ease(Tween.EASE_OUT)
	tween_hover.tween_property(boton_aleatorio, "scale", hover_scale, tween_hover_duration)
	pass # Replace with function body.


func _on_aleatorio_mouse_exited() -> void:
#	if tween_hover:
#		tween_hover.kill()
	tween_hover = create_tween()
	tween_hover.set_trans(Tween.TRANS_SINE)
	tween_hover.set_ease(Tween.EASE_OUT)
	tween_hover.tween_property(boton_aleatorio, "scale", default_scale, tween_hover_duration)
	pass # Replace with function body.


func _on_nuevo_mouse_entered() -> void:
#	if tween_hover:
#		tween_hover.kill()
	tween_hover = create_tween()
	tween_hover.set_trans(Tween.TRANS_SINE)
	tween_hover.set_ease(Tween.EASE_OUT)
	tween_hover.tween_property(boton_nuevo, "scale", hover_scale, tween_hover_duration)
	pass # Replace with function body.


func _on_nuevo_mouse_exited() -> void:
#	if tween_hover:
#		tween_hover.kill()
	tween_hover = create_tween()
	tween_hover.set_trans(Tween.TRANS_SINE)
	tween_hover.set_ease(Tween.EASE_OUT)
	tween_hover.tween_property(boton_nuevo, "scale", default_scale, tween_hover_duration)
	pass # Replace with function body.


func _on_aleatorio_button_down() -> void:
	if tween_logo_click1: 
		tween_logo_click1.kill()
	if tween_hover:
		tween_hover.kill()
	boton_aleatorio.scale = Vector2(0.9, 0.9)
	pass # Replace with function body.


func _on_aleatorio_button_up() -> void:
	tween_logo_click1 = create_tween()
	tween_logo_click1.set_ease(Tween.EASE_OUT)
	tween_logo_click1.set_trans(Tween.TRANS_SPRING)
	
	# restores the scale smoothly in 0.25 seconds
	tween_logo_click1.tween_property(boton_aleatorio, "scale", Vector2(1,1), 0.25)
	pass # Replace with function body.


func _on_nuevo_button_down() -> void:
	if tween_logo_click1: 
		tween_logo_click1.kill()
	if tween_hover:
		tween_hover.kill()
	boton_nuevo.scale = Vector2(0.9, 0.9)
	pass # Replace with function body.


func _on_nuevo_button_up() -> void:
	tween_logo_click1 = create_tween()
	tween_logo_click1.set_ease(Tween.EASE_OUT)
	tween_logo_click1.set_trans(Tween.TRANS_SPRING)
	
	# restores the scale smoothly in 0.25 seconds
	tween_logo_click1.tween_property(boton_nuevo, "scale", Vector2(1,1), 0.25)

	pass # Replace with function body.
