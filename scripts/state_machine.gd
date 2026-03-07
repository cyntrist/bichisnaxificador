extends Node

@export_category("Array de escenas en el orden de Global.Scenes")
@export var scenes: Array[PackedScene] = [] 
@export var initial_scene : PackedScene
@onready var fade = $Fade

var currentScene : Scene
@onready var sound = $Sound

func _ready() -> void:
	Global.sm = self
	Global.sound = sound
	Global.on_transition_end.connect(_on_fade_end)
	Global.on_transition_begin.connect(_on_fade_begin)

	currentScene = scenes[Global.next_scene].instantiate()
	$Scenes.add_child(currentScene)
	currentScene.on_enable()
	
	Global.current_scene = Global.next_scene
	pass 

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

func _on_fade_begin(speed = 1.0) -> void:
	# escena a apagar
	if currentScene:
		var lastScene: Scene = currentScene
		lastScene.on_disable()
		var tween : Tween = create_tween()
		tween.tween_property(lastScene, "modulate:a", 0, speed)
		tween.finished.connect(func(): 
			lastScene.queue_free()
			currentScene.on_enable()
			Global.current_scene = Global.next_scene
		)
		currentScene = scenes[Global.next_scene].instantiate()
		currentScene.z_index = 0
		lastScene.z_index = 1
		$Scenes.add_child(currentScene)
#		$Scenes.move_child(currentScene, 0)
		
	else:
		# escena a encender
		currentScene = scenes[Global.next_scene].instantiate()
		$Scenes.add_child(currentScene)
		currentScene.on_enable()
		Global.current_scene = Global.next_scene

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
