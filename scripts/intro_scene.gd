extends Scene

@export var intro_duration : float = 1.0

func on_enable() -> void:
#	Global.sound.play_bgm("bgmusicSample")
	$Splash.play("loop")
	await Global.timer(intro_duration)
	Global.change_scene(Global.Scenes.MENU)
	Global.sound.play_bgm("welcome", true)
	pass
