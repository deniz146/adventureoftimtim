extends Control
@onready var label = $Label
@onready var label_2 = $Label2
@onready var label_3 = $Label3
@onready var label_4 = $Label4
@onready var label_5 = $Label5
@onready var label_6 = $Label6


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_game_pressed():
	Loader.change_level("res://adventur of timtim/cutscene.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://adventur of timtim/options menu.tscn")


func _on_quit_pressed():
	get_tree().quit()





func _on_back_pressed():
	get_tree().change_scene_to_file("res://adventur of timtim/main_menu.tscn")


func _on_start_game_mouse_entered():
	label.hide()
	label_4.show()


func _on_start_game_mouse_exited():
	label.show()
	label_4.hide()

func _on_options_mouse_entered():
	label_2.hide()
	label_5.show()



func _on_options_mouse_exited():
	label_5.hide()
	label_2.show()



func _on_quit_mouse_entered():
	label_3.hide()
	label_6.show()



func _on_quit_mouse_exited():
	label_6.hide()
	label_3.show()

