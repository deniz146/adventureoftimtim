extends Node

var loading_screen = load("res://adventur of timtim/loading_screen.tscn")
var scenepath : String

func change_level(path):
	scenepath = path
	get_tree().change_scene_to_packed(loading_screen)
