### GLOBAL // audio.gd

extends Node

@onready var bg_music: AudioStreamPlayer = $BgMusic
@onready var bg_2: AudioStreamPlayer = $Bg2
@onready var area_2_music = $Area2Music
@onready var minigame_2_music = $Minigame2Music
@onready var achievement: AudioStreamPlayer = $Achievement
@onready var congrats: AudioStreamPlayer = $Congrats
@onready var click_sfx_2 = $ClickSfx2
@onready var page_flip = $PageFlip
@onready var click_sfx_3 = $ClickSfx3

func play_page_flip_sfx():
	page_flip.play()
	
func button_click():
	click_sfx_2.play()

func game_paused_sfx():
	click_sfx_3.play()

# Title screen music
func play_music1():
	bg_music.play()
	
func stop_music1():
	bg_music.stop()

# Area 1 music
func play_music2():
	bg_2.play()
	
func stop_music2():
	bg_2.stop()

# Area 2 music
func play_area_2_music():
	area_2_music.play()

func stop_area_2_music():
	area_2_music.stop()

# Minigame 2 music
func play_minigame_2_music():
	minigame_2_music.play()

func stop_minigame_2_music():
	minigame_2_music.stop()

func play_achieve():
	achievement.play()
	
func stop_achieve():
	achievement.stop()
	
func play_congrats():
	congrats.play()
	
func stop_congrats():
	congrats.stop()
