extends Sprite2D

@export var speed : float = 100.0
@export var duration : float = 10.0
@export var tween_duration : float = 3.0

var current_speed : Vector2

func _ready():
	current_speed = Vector2(speed, 0)
	_schedule_direction_change()

func _process(delta):
	region_rect.position.x += current_speed.x * delta
	region_rect.position.y += current_speed.y * delta

func _schedule_direction_change():
	await Global.timer(duration)
	
#	var tween := create_tween()
#	tween.set_ease(Tween.EASE_IN_OUT)
#	tween.tween_property(self, "current_speed:x", -current_speed.x, tween_duration).set_trans(Tween.TRANS_SINE)

	var new_dir = current_speed.rotated(deg_to_rad(45)).normalized() * speed

	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "current_speed", new_dir, tween_duration)

	tween.finished.connect(_schedule_direction_change)
