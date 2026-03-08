extends Scene

@onready var exit_button : TextureButton = $Exit
@onready var retry_button : TextureButton = $Retry/Button
@onready var retry : Control = $Retry
@onready var retry_button_shape : TextureRect = $Retry/Shape
@onready var cross : TextureRect = $Cross
@onready var dibujar : RichTextLabel = $Dibujar
@onready var bicho : CenterContainer = $Bicho
@onready var bicho_texto : Label = $Bicho/Margenes/Texto
@onready var comida : CenterContainer = $Comida
@onready var comida_texto : Label = $Comida/Margenes/Texto
@onready var animator : AnimationPlayer = $AnimationPlayer
var rotating : bool = false
var pegado_scale = Vector2(0.7,0.7)
var big_scale = Vector2(0.85,0.85)
var tween_comida : Tween
var tween_bicho : Tween
@export var min_rotation : float = -5.0
@export var max_rotation : float = 5.0
var tween_hover : Tween
var tween_click : Tween
var hovering_exit : bool = false
var hover_scale = Vector2(0.8, 0.8)
var hover_scale2 = Vector2(1.1, 1.1)
var default_scale = Vector2(0.7, 0.7)
var default_scale2 = Vector2(1.0, 1.0)
var tween_hover_duration = 0.2


var nombres_insectos := [
	"Masca",
	"Ronda",
	"Mosca",
	"Mosquito",
	"Termita",
	"Escolopendra",
	"Ciempiés",
	"Milpiés",
	"Mantis",
	"Cangrejo",
	"Gamba",
	"Langostino",
	"Cochinilla",
	"Bicho Palo",
	"Abeja",
	"Tarántula",
	"Grillo",
	"Saltamontes",
	"Pulga",
	"Garrapata",
	"Langosta",
	"Kril",
	"Percebe",
	"Cangrejo herradura",
	"Zapatero",
	"Escorpión",
	"Luciérnaga",
	"Polilla",
	"Cigarra",
	"Mariposa",
	"Mariquita",
	"Libélula",
	"Oruga",
	"Gorgojo",
	"Cucaracha",
	"Hormiga",
	"Escarabajo",
	"Avispa",
	"Abejorro",
	"Araña"
]

var nombres_comidas := [
	"Pizza",
	"Hamburguesa",
	"Sandwich",
	"Bocadillo",
	"Jamón",
	"Pistacho",
	"Lomo",
	"Ternera",
	"Curry",
	"Arroz",
	"Cocido",
	"Sopa",
	"Fideuá",
	"Leche",
	"Pescado",
	"Canelón",
	"Lasaña",
	"Pan",
	"Bollo",
	"Macha",
	"Galleta",
	"Bizcocho",
	"Batido",
	"Refresco",
	"Nachos",
	"Infusión",
	"Cerveza",
	"Cóctel",
	"Café",
	"Helado",
	"Tortilla",
	"Quesadilla",
	"Huevo",
	"Chocolate",
	"Canónigo",
	"Tomate",
	"Cereales",
	"Paella",
	"Taco",
	"Pasta",
	"Fideos",
	"Ensalada",
	"Paella",
	"Croqueta"
]

func _ready() -> void:
	cross.visible = false
	retry.visible = false
	dibujar.visible = false
	comida.visible = false
	bicho.visible = false

func on_enable() -> void:
	dibujar.visible = true
	var tween2 = create_tween()
	tween2.set_trans(Tween.TRANS_SINE)
	tween2.set_ease(Tween.EASE_IN_OUT)
	tween2.tween_property(exit_button, "modulate", Color(1,1,1,0.5), 1.0)
	
	dibujar.scale = Vector2(0,0)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(dibujar, "scale", Vector2(0.9,0.9), 1.5)
	tween.finished.connect(mostrar_cruz)
	pass
	
	
func mostrar_cruz():
	## VERSION PEGADA:
#	if cross.visible: return
#	cross.modulate = Color(1,1,1,1)
#	cross.visible = true 
#	cross.scale = Vector2(2,2)
#	
#	var tween2 = create_tween()
#	tween2.set_trans(Tween.TRANS_BACK)
#	tween2.set_ease(Tween.EASE_IN)
#	tween2.tween_property(cross, "scale", Vector2(1.8,1.8), 0.2)
#	tween2.finished.connect(mostrar_bicho)

	if cross.visible: return
	cross.modulate = Color(1,1,1,0)
	cross.visible = true 
	cross.scale = Vector2(1.5,1.5)
	
	var tween2 = create_tween()
	tween2.set_trans(Tween.TRANS_SINE)
	tween2.set_ease(Tween.EASE_IN_OUT)
	tween2.tween_property(cross, "scale", Vector2(1.8,1.8), 0.2)
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(cross, "modulate", Color(1,1,1,1), 0.5)
	tween.finished.connect(mostrar_bicho)
	pass
	
func mostrar_bicho():
	bicho.visible = true
	bicho.scale = big_scale
	bicho_texto.text = nombres_insectos.pick_random()
	bicho.rotation_degrees = Global.random.randf_range(min_rotation,max_rotation)
	if tween_bicho: tween_bicho.kill()
	tween_bicho = create_tween()
	tween_bicho.set_trans(Tween.TRANS_BACK)
	tween_bicho.set_ease(Tween.EASE_OUT)
	tween_bicho.tween_property(bicho, "scale", pegado_scale, 0.5)
	tween_bicho.finished.connect(mostrar_comida)
	pass
	
func mostrar_comida():
	comida.visible = true
	comida.scale = big_scale
	comida_texto.text = nombres_comidas.pick_random()
	comida.rotation_degrees = Global.random.randf_range(min_rotation,max_rotation)
	if tween_comida: tween_comida.kill()
	tween_comida = create_tween()
	tween_comida.set_trans(Tween.TRANS_BACK)
	tween_comida.set_ease(Tween.EASE_OUT)
	tween_comida.tween_property(comida, "scale", pegado_scale, 0.5)
	tween_comida.finished.connect(mostrar_boton)
	pass

func mostrar_boton():
	if retry.visible: return
	retry.visible = true
	retry.scale = Vector2(0.9,1.1)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(retry, "scale", Vector2(1.1,0.9), 0.5)
	tween.tween_property(retry, "scale", Vector2(1.0,1.0), 0.5)
	tween.finished.connect(func():
		if not rotating:
			rotating = true
			animator.play("rotate")
	)
	pass
	
	
	
	

func _on_exit_mouse_entered() -> void:
	hovering_exit = true
	tween_hover = create_tween()
	tween_hover.set_trans(Tween.TRANS_SINE)
	tween_hover.set_ease(Tween.EASE_OUT)
	tween_hover.parallel().tween_property(exit_button, "scale", hover_scale, tween_hover_duration)
	tween_hover.parallel().tween_property(exit_button, "modulate", Color(1,1,1,1), tween_hover_duration)
	pass # Replace with function body.


func _on_exit_mouse_exited() -> void:
	hovering_exit = false
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
#	exit_button.scale = Vector2(0.9, 0.9)
	tween_click = create_tween()
	tween_click.set_ease(Tween.EASE_OUT)
	tween_click.set_trans(Tween.TRANS_EXPO)
	tween_click.tween_property(exit_button, "scale", Vector2(0.9,0.9), 0.1)
	pass # Replace with function body.



func _on_exit_button_up() -> void:
	tween_click = create_tween()
	tween_click.set_ease(Tween.EASE_OUT)
	tween_click.set_trans(Tween.TRANS_SPRING)
	tween_click.tween_property(exit_button, "scale", Vector2(1,1), 0.25)
	Global.change_scene(Global.Scenes.MENU)
	pass # Replace with function body.


func _on_repeat_mouse_entered() -> void:
	hovering_exit = true
	tween_hover = create_tween()
	tween_hover.set_trans(Tween.TRANS_SINE)
	tween_hover.set_ease(Tween.EASE_OUT)
	tween_hover.tween_property(retry, "scale", hover_scale2, tween_hover_duration)
	pass # Replace with function body.


func _on_repeat_mouse_exited() -> void:
	hovering_exit = false
	tween_hover = create_tween()
	tween_hover.set_trans(Tween.TRANS_SINE)
	tween_hover.set_ease(Tween.EASE_OUT)
	tween_hover.tween_property(retry, "scale", default_scale2, tween_hover_duration)
	pass # Replace with function body.




func _on_repeat_button_up() -> void:
	tween_click = create_tween()
	tween_click.set_ease(Tween.EASE_OUT)
	tween_click.set_trans(Tween.TRANS_SPRING)
	tween_click.tween_property(retry, "scale", Vector2(1,1), 0.25)
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(retry_button_shape, "rotation", TAU, 1.0).as_relative()
	
	mostrar_bicho()
	
	pass # Replace with function body.


func _on_retry_button_down() -> void:
	if tween_click: 
		tween_click.kill()
	if tween_hover:
		tween_hover.kill()
#	exit_button.scale = Vector2(0.9, 0.9)
	tween_click = create_tween()
	tween_click.set_ease(Tween.EASE_OUT)
	tween_click.set_trans(Tween.TRANS_EXPO)
	tween_click.tween_property(retry, "scale", Vector2(0.9,0.9), 0.1)
	pass # Replace with function body.
