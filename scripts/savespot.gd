extends Node
@onready var player = %player
@onready var gpu_particles_2d = $GPUParticles2D

@onready var animation_player = $AnimationPlayer
@onready var point_light_2d_3 = $PointLight2D3
@onready var camera_2d = $"../player/Camera2D"
var speed = 1
@onready var camerain_timer = $camerainTimer
@onready var cameraout_timer = $cameraoutTimer
@onready var sprite_2d_2 = $Sprite2D2
@onready var audio_stream_player_2d_2 = $AudioStreamPlayer2D2
@onready var shop = $shop
@onready var animator = $"../AnimationPlayer"
@onready var animate = $"../AnimationPlayer"


@onready var audio_stream_player_2d = $AudioStreamPlayer2D
var shakecamera = true
var cameragoin
var cameragoout

var played = false
var cansave = false

var save_path = "user://savegame.json"
func _process(delta):
	if audio_stream_player_2d.playing == false:
		audio_stream_player_2d.play()
	if audio_stream_player_2d_2.playing == false:
		audio_stream_player_2d_2.play()

func _ready():

	audio_stream_player_2d.play()
	audio_stream_player_2d_2.play()
	sprite_2d_2.hide()
	gpu_particles_2d.emitting = false
	sprite_2d_2.hide()
	point_light_2d_3.hide()
func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(player.bullet_count)
	file.store_var(player.mana)
	file.store_var(player.health)
	file.store_var(player.havebow)
	file.store_var(player.havefire)
	file.store_var(player.havespecial1)
	file.store_var(player.havespecial2)
	file.store_var(player.position.x)
	file.store_var(player.position.y)
	file.store_var(player.moveactive)
	file.store_var(player.shootactive)

	file.store_var(player.health)
func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		player.bullet_count = file.get_var(player.bullet_count)
		player.mana = file.get_var(player.mana)
		player.health = file.get_var(player.health)
		player.havebow = file.get_var(player.havebow)
		player.havefire = file.get_var(player.havefire)
		player.havespecial1 = file.get_var(player.havespecial1)
		player.havespecial2 = file.get_var(player.havespecial2)
		player.position.x = file.get_var(player.position.x)
		player.position.y = file.get_var(player.position.y)
		player.moveactive = file.get_var(player.moveactive)
		player.shootactive = file.get_var(player.shootactive)

		player.health = file.get_var(player.health)
	else:
		player.bullet_count = 0


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sprite_2d_2.show()
	cansave = true
	gpu_particles_2d.emitting = true
	point_light_2d_3.show()


	save()
	print("save")
		
		
	animation_player.play("saved lost")

	
	
	





func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):

	cansave = false
	shakecamera = false


