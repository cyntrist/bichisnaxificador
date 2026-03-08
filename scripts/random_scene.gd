extends Scene

@onready var random_bug_root : Node2D = $Bugsnax
@onready var random_bug_sprite : AnimatedSprite2D = $Bugsnax/Random
@onready var chosen_sprite : Sprite2D = $Bugsnax/Chosen
@onready var chosen_text : Label = $Texto/Label
@onready var chosen_text_node : Control = $Texto

@export var random_duration :float = 1.0 
@export var random_scale :Vector2 = Vector2(1.5,1.5) 

func _ready() -> void:
	pass

func on_enable() -> void:
	randomize() 
	random_bug_sprite.play("random")
	var frame_count = random_bug_sprite.sprite_frames.get_frame_count("random")
	random_bug_sprite.frame = randi() % frame_count
	
	random_bug_root.visible = true
	random_bug_root.scale = Vector2(0,0)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(random_bug_root, "scale", random_scale, random_duration)
	tween.finished.connect(choose)
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
	chosen_text_node.visible = true
	chosen_text.text = format_name(key)
	pass
	
func on_disable() -> void:
	pass
