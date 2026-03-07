extends Node

@export_category("Array de escenas en el orden de Global.Scenes")
@export var scenes: Array[PackedScene] = [] 
@onready var fade = $Fade

var currentScene : Scene
@onready var sound = $Sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	## INICIALIZAR GLOBAL
	Global.sm = self
	Global.sound = sound
	
	## CONECTAR SEÑALES
	Global.on_transition_end.connect(_on_fade_end)
	Global.on_game_end.connect(_on_game_end)
	
	## PRIMER CAMBIO DE ESCENA
	Global.change_scene(Global.Scenes.INTRO)
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	var scene = Global.Scenes.NULL;
	if event.is_action_pressed("1"):
		scene = Global.Scenes.INTRO
	if event.is_action_pressed("2"):
		scene = Global.Scenes.GAME
	#if event.is_action_pressed("ui_cancel"):
		#get_tree().quit()
	if (scene != Global.Scenes.NULL):
		Global.change_scene(scene)

func _on_game_end():
	pass

func _on_fade_end() -> void: #justo antes del fadeout
	# escena a apagar
	if currentScene:
		currentScene.on_disable()
		currentScene.queue_free()
	# escena a encender
	currentScene = scenes[Global.next_scene].instantiate()
	$Scenes.add_child(currentScene)
	currentScene.on_enable()
	
	Global.current_scene = Global.next_scene
