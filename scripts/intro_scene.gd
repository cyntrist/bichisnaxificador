extends Scene

@export var intro_duration : float = 1.0

func on_enable() -> void:
	$Splash.play("loop")
	await Global.timer(intro_duration)
	Global.change_scene(Global.Scenes.MENU)
	Global.sound.set_bgm_volume_db(4.0)
	Global.sound.set_sfx_volume_db(8.0)
	pass

func on_disable() -> void:
	Global.sound.play_sfx("newquest")
	Global.bgm.play()
	
	
