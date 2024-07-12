extends Control

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



# Called when the node enters the scene tree for the first time.
func _ready():
	volume.hide()
	graphics.hide()
	back.hide()
	windowmodebutton.hide()
	resbutton.hide()


func _process(delta):
	if Input.is_action_just_pressed("menu"):
		volume.show()
		graphics.show()
		back.show()
		
		
		
		
func _on_volume_pressed():
	windowmodebutton.hide()
	resbutton.hide()


func _on_back_pressed():
	volume.hide()
	graphics.hide()
	back.hide()
	windowmodebutton.hide()
	resbutton.hide()
func _on_graphics_pressed():
	
	windowmodebutton.show()
	resbutton.show()

func _on_volume_mouse_entered():
	label.hide()
	label_2.show()


func _on_volume_mouse_exited():
	label_2.hide()
	label.show()


func _on_graphics_mouse_entered():
	label_3.hide()
	label_4.show()


func _on_graphics_mouse_exited():
	label_4.hide()
	label_3.show()


func _on_back_mouse_entered():
	label_5.hide()
	label_6.show()


func _on_back_mouse_exited():
	label_6.hide()
	label_5.show()
