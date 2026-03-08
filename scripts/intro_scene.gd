extends Scene

func on_enable() -> void:
#	Global.sound.play_bgm("bgmusicSample")
	$Splash.play("loop")
	await Global.timer(1.0)
	Global.change_scene(Global.Scenes.MENU)
	pass
