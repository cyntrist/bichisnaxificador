extends RichTextLabel

#const FULL_TEXT := "[bounce][rainbow freq=0.18 sat=0.5 val=1 speed=0.05][wave amp=50 freq=5 connected=1]¡A dibujar![/wave][/rainbow][/bounce]"

@export var duration := 1.5
#const BounceTextEffect = preload("res://effects/bounce_text_effect.gd") #NO FUNCIONA
var last_visible := 0

func _ready():
	bbcode_enabled = true
#	install_effect(BounceTextEffect.new()) # NO FUNCIONA
#	visible_characters = 0

func reveal_text():
	var total := get_total_character_count()
	var tween := create_tween()
	tween.tween_property(self, "visible_characters", total, duration)
	

func _process(_delta):
	if visible_characters > last_visible:
		var diff := visible_characters - last_visible
		for i in diff:
			Global.sound.play_sfx("hoehit", 0.2)
		last_visible = visible_characters
