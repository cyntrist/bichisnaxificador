extends Node

## SEÑALES
# flujo
@warning_ignore("unused_signal")
signal on_transition_begin(speed)
@warning_ignore("unused_signal")
signal on_transition_end
@warning_ignore("unused_signal")
signal on_enable(scene)
@warning_ignore("unused_signal")
signal on_disable(scene)
@warning_ignore("unused_signal")
signal on_game_end()
@warning_ignore("unused_signal")
signal start_text

var sprites_folder: String = "res://assets/images/sprites"
var bugsnaxs: Dictionary = {}
var loader_thread: Thread

## maquina de estados y variables de flujo
var sm # state machine
var current_scene = Scenes.NULL 
var next_scene = Scenes.INTRO
## MUY IMPORTANTE: MISMO ORDEN QUE EN EL SERIALIZED ARRAY DE LA STATEMACHINE
enum Scenes { INTRO, MENU, RANDOM, NEW, NULL}
var transitioning : bool = false

## sonido
var sfx
var bgm
var sound : SoundManager

var coolDown = 0.5
var startCoolDown = false
var random = RandomNumberGenerator.new()

func _ready() -> void:
	load_bugsnaxes_async(sprites_folder)
	pass

func  _process(delta: float) -> void:
	if loader_thread and not loader_thread.is_alive():
		bugsnaxs = loader_thread.wait_to_finish()
		loader_thread = null
	pass

func change_scene(next : Global.Scenes, speed = 1.0, force = true):
	Global.next_scene = next
	if ((current_scene != next || force) and not transitioning):
		transitioning = true
		Global.on_transition_begin.emit(speed)

func timer(tiempo = 1.0) -> Signal:
	return get_tree().create_timer(tiempo).timeout
	
	
func load_bugsnaxes_async(path: String):
	loader_thread = Thread.new()
	loader_thread.start(_thread_load_bugsnaxes.bind(path))
	
func _thread_load_bugsnaxes(path: String):
	var result := {}
	_load_bugsnaxes(path, result)
	return result	
	
func _load_bugsnaxes(path: String, target_dict: Dictionary) -> void:
	var files: PackedStringArray = ResourceLoader.list_directory(path)

	for file in files:
		var full_path = path + "/" + file

		if ResourceLoader.exists(full_path, "Texture2D"):
			var key := file.get_basename()
			target_dict[key] = load(full_path)