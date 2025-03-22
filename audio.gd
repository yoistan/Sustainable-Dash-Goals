extends Node

@onready var bg_music: AudioStreamPlayer = $BgMusic
@onready var bg_2: AudioStreamPlayer = $Bg2

func play_music1():
	bg_music.play()
	
func stop_music1():
	bg_music.stop()
	
func play_music2():
	bg_2.play()
	
func stop_music2():
	bg_2.stop()
