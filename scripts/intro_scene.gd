extends Scene

@export var intro_duration : float = 1.0

func on_enable() -> void:
	$Splash.play("loop")
	await Global.timer(intro_duration)
	Global.change_scene(Global.Scenes.MENU)
	Global.bgm.volume_db = 2.0
	Global.sound.set_sfx_volume_db(8.0)
	pass

func on_disable() -> void:
	Global.sound.play_sfx("newquest")
	await Global.timer(0.2)
	Global.bgm.play()
	
	
