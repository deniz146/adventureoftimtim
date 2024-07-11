extends CanvasLayer

@export var player : CharacterBody2D
@export var tilemap : TileMap
@onready var sub_viewport = $SubViewportContainer/SubViewport
var minimapplayer
@onready var sub_viewport_container = $SubViewportContainer
@onready var sprite_2d = $Sprite2D

@onready var camera_2d = $SubViewportContainer/SubViewport/Camera2D

func _ready():
	sub_viewport_container.hide()
	minimapplayer = player.duplicate()
	sprite_2d.hide()
	sub_viewport.add_child(tilemap.duplicate())
	sub_viewport.add_child(minimapplayer)
	
func _process(delta):
	camera_2d.position = player.position
	minimapplayer.position = player.position
	
	if Input.is_action_just_pressed("map"):
		sub_viewport_container.show()
		sprite_2d.show()
	if Input.is_action_just_released("map"):
		sub_viewport_container.hide()
		sprite_2d.hide()
