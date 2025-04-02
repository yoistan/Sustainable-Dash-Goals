### Global.gd

extends Node

var player : Node = null
var touch_controls : Node = null
var minigame_1_done : bool = false
var minigame_2_started : bool = false
var minigame_2_done : bool = false
var current_scene : String
var last_scene : String

# file name of areas for reference
var area_1_name : String = "area_1_Outside_Rizal"
var area_2_name : String = "area_2_Rizal_Lobby"
var area_2_hallway_name : String = "area_2-1_Rizal_Hallway"
var area_2_hallway_room_1 : String = "area_2-1_room_1"
var area_2_hallway_room_2 : String = "area_2-1_room_2"
var area_2_hallway_room_3 : String = "area_2-1_room_3"
var area_2_hallway_room_4 : String = "area_2-1_room_4"

# checks if the player has visited it
var area_2_lobby_is_new : bool = true
var area_2_hallway_is_new : bool = true

# spawns
var default_spawn_area_1 : Vector2 = Vector2(61.0, 55.0)

var area_1_players_last_location : Vector2 = default_spawn_area_1
var area_2_players_last_location : Vector2
var area_2_hallway_players_last_location : Vector2
