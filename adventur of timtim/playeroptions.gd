extends Control
@onready var echo = $echo
@onready var click = $click

@onready var label = $volume/Label
@onready var label_2 = $volume/Label2
@onready var label_3 = $graphics/Label3
@onready var label_4 = $graphics/Label4
@onready var label_5 = $back/Label5
@onready var label_6 = $back/Label6
@onready var windowmodebutton = $windowmodebutton
@onready var resbutton = $resbutton
@onready var volume = $volume
@onready var graphics = $graphics
@onready var back = $back
@onready var label_q = $QUIT/LabelQ
@onready var label_q_1 = $QUIT/LabelQ1
@onready var quit = $QUIT



# Called when the node enters the scene tree for the first time.
func _ready():
	volume.hide()
	graphics.hide()
	back.hide()
	windowmodebutton.hide()
	resbutton.hide()
	quit.hide()

func _process(delta):
	if Input.is_action_just_pressed("menu"):
		volume.show()
		graphics.show()
		back.show()
		quit.show()
		
		
		
func _on_volume_pressed():
	windowmodebutton.hide()
	resbutton.hide()
	click.play()

func _on_back_pressed():
	volume.hide()
	graphics.hide()
	back.hide()
	windowmodebutton.hide()
	resbutton.hide()
	quit.hide()
	click.play()
func _on_graphics_pressed():
	
	windowmodebutton.show()
	resbutton.show()
	click.play()
func _on_volume_mouse_entered():
	label.hide()
	label_2.show()
	echo.play()

func _on_volume_mouse_exited():
	label_2.hide()
	label.show()


func _on_graphics_mouse_entered():
	label_3.hide()
	label_4.show()
	echo.play()

func _on_graphics_mouse_exited():
	label_4.hide()
	label_3.show()


func _on_back_mouse_entered():
	label_5.hide()
	label_6.show()
	echo.play()

func _on_back_mouse_exited():
	label_6.hide()
	label_5.show()


func _on_quit_pressed():
	Loader.change_level("res://adventur of timtim/main_menu.tscn")
	click.play()

func _on_quit_mouse_entered():
	label_q.hide()
	label_q_1.show()
	echo.play()

func _on_quit_mouse_exited():
	label_q.show()
	label_q_1.hide()
