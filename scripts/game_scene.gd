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
	