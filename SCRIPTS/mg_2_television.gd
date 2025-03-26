extends Node2D

@onready var tv_screen = $TVScreen

var on_color = Color("#f5aa7f")
var off_color = Color("#161616")

func turn_on_tv():
	tv_screen.color = on_color

func turn_off_tv():
	tv_screen.color = off_color
