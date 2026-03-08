extends Scene

@onready var logo_letras = $Logo/Logo
@onready var logo_fondo = $Logo/Fondo

@export var tween_logo_speed = 1.0
@export var tween_logo_trans : Tween.TransitionType
@export var tween_logo_ease : Tween.EaseType

func _init() -> void:
	pass

func _draw() -> void:
	pass

func _ready() -> void:
	pass

func on_enable() -> void:
	var tween := create_tween()
	tween.set_ease(tween_logo_ease)
	tween.set_trans(tween_logo_trans)
	tween.tween_property(logo_letras, "position:y", 160, 1.0)
	
	await Global.timer(0.2)
	var tween2 := create_tween()
	tween2.set_ease(tween_logo_ease)
	tween2.set_trans(tween_logo_trans)
	tween2.tween_property(logo_fondo, "position:y", 120, 1.0)
	pass

func on_disable() -> void:
	pass
	