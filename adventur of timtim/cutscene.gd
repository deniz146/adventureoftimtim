extends VideoStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("skip cutscene"):
		Loader.change_level("res://adventur of timtim/game.tscn")


func _on_finished():
	Loader.change_level("res://adventur of timtim/game.tscn")
