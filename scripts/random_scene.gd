extends Scene

@onready var random_bug_root : Node2D = $Bugsnax
@onready var random_bug_sprite : AnimatedSprite2D = $Bugsnax/Random
@onready var chosen_sprite : Sprite2D = $Bugsnax/Chosen
@onready var chosen_text : Label = $Texto/Label
@onready var chosen_text_node : Control = $Texto
@onready var animator : AnimationPlayer = $AnimationPlayer

@onready var exit_button : TextureButton = $Exit
var tween_hover : Tween
var tween_click : Tween
var tween_exit_enter : Tween
var hovering_exit : bool = false
var hover_scale = Vector2(1.1, 1.1)
var default_scale = Vector2(1.0, 1.0)
var tween_hover_duration = 0.2

@export var random_duration :float = 1.0 
@export var random_scale :Vector2 = Vector2(1.5,1.5) 

var tween_chosen : Tween

func _ready() -> void:
	pass

func on_enable() -> void:
	randomize() 
	random_bug_sprite.play("random")
	var frame_count = random_bug_sprite.sprite_frames.get_frame_count("random")
	random_bug_sprite.frame = randi() % frame_count
	var sentido : bool = randi_range(0, 1)
	if (sentido):
		random_bug_sprite.speed_scale *= -1
	
	random_bug_root.visible = true
	chosen_sprite.visible = false
	chosen_text_node.visible = false
	random_bug_root.scale = Vector2(0,0)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(random_bug_root, "scale", random_scale, random_duration)
	tween.finished.connect(choose)
	
	if not hovering_exit:
		tween_exit_enter = create_tween()
		tween_exit_enter.set_trans(Tween.TRANS_SINE)
		tween_exit_enter.set_ease(Tween.EASE_IN_OUT)
		tween_exit_enter.tween_property(exit_button, "modulate", Color(1,1,1,0.5), 1.0)
	pass
	
func format_name(key: String) -> String:
	var text = key.replace("-", " ")
	text = text.capitalize()
#	text = text.replace(" ", "\n")
	return text	

func choose():
	var key : String  = Global.bugsnaxs.keys().pick_random()
	var value : Texture2D = Global.bugsnaxs[key] # el sprite

	chosen_sprite.texture = value
	random_bug_sprite.stop()
	random_bug_sprite.visible = false
	chosen_text_node.visible = true
	chosen_sprite.visible = true
	chosen_text.text = format_name(key)
	animator.play("chosen")
	
	var offset : float = 0
	var time : float = 0.2
	
	tween_chosen = create_tween()
	tween_chosen.set_trans(Tween.TRANS_BACK)
	tween_chosen.set_ease(Tween.EASE_IN)
	tween_chosen.tween_property(random_bug_root, "scale", Vector2(1,1), time)
	var tween2 = create_tween()
	tween2.set_trans(Tween.TRANS_SINE)
	tween2.set_ease(Tween.EASE_IN)
	tween2.tween_property(random_bug_root, "position:y", random_bug_root.position.y - offset, time)
	
	await Global.timer(0.2)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(chosen_text_node, "scale", Vector2(0.8,0.8), time)
	var tween3 = create_tween()
	tween3.set_trans(Tween.TRANS_SINE)
	tween3.set_ease(Tween.EASE_IN)
	tween3.tween_property(chosen_text_node, "position:y", chosen_text_node.position.y - offset, time)
	pass
	
func on_disable() -> void:
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


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "chosen":
		animator.play("rotation")
		$Dibujar.reveal_text()
	pass # Replace with function body.
