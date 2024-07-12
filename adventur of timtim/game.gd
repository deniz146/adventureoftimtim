extends Node
@onready var playeroptions = $CanvasLayer/playeroptions
var paused = false


func _process(delta):
	if Input.is_action_just_pressed("menu"):
		pausemenu()
		
func pausemenu():
	if paused:
		playeroptions.hide()
	else:
		playeroptions.show()
		
	paused = !paused
