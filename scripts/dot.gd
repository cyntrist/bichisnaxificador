extends Sprite2D

@export var speed : float = 100.0
@export var duration : float = 6.0
@export var tween_duration : float = 3.0

var current_speed : float 

func _ready():
	current_speed = speed
	_schedule_direction_change()

func _process(delta):
	region_rect.position.x += current_speed * delta

func _schedule_direction_change():
	await Global.timer(duration)
	
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "current_speed", -current_speed, tween_duration).set_trans(Tween.TRANS_SINE)
	
	tween.finished.connect(_schedule_direction_change)
