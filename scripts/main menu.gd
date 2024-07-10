extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://adventur of timtim/loading_screen.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://adventur of timtim/options menu.tscn")


func _on_quit_pressed():
	get_tree().quit()





func _on_back_pressed():
	get_tree().change_scene_to_file("res://adventur of timtim/main_menu.tscn")
