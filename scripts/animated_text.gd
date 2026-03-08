extends RichTextLabel

const FULL_TEXT := "[rainbow freq=0.18 sat=0.5 val=1 speed=0.05][wave amp=50 freq=5 connected=1]¡A dibujar![/wave][/rainbow]"

@export var duration := 1.5

func _ready():
	bbcode_enabled = true
	text = FULL_TEXT
	visible_characters = 0

func reveal_text():
	var total := get_total_character_count()
	var tween := create_tween()
	tween.tween_property(self, "visible_characters", total, duration)