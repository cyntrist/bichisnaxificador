extends Scene

@onready var random_bug_root : Node = $Bugsnax
@onready var random_bug_sprite : Node = $Bugsnax/Random

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
	pass
	
func on_disable() -> void:
	pass
