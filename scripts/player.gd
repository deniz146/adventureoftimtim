extends CharacterBody2D
var kickactive = true
@onready var kickover = $kickover
@onready var idleallow = $idleallow
@onready var punchnkick = $punchnkick
@onready var idlecanreturnaftershoot = $idlecanreturnaftershoot
@onready var player = $"."
@onready var punchallow = $PUNCHALLOW
@onready var k_ckallow = $"KİCKALLOW"
@onready var _dead = $dead
@onready var playeroptions = $playeroptions
@onready var firedamage = $firedamage
@onready var firecol = $firedamage/firecol
var dead = false
var left = false
var right = false
@onready var kickcol = $kickcol/CollisionShape2D
@onready var punchcol = $punchcol/CollisionShape2D
@onready var shop = $"../shop"
var animactive = true
@onready var bulletspawn = $bulletspawn
var action_to_check = ["left", "right", "jump", "magic", "shoot", "punch", "kick"]
var keys_to_check = [KEY_A, KEY_D, KEY_SPACE, KEY_Q, KEY_E, KEY_Z, KEY_C, KEY_SHIFT, KEY_CTRL]
var stopbow = true
var punchactive = true
@onready var punchover = $punchover
@onready var punchcombo = $punchcombo
@onready var punchcombo_2 = $punchcombo2
var punchcomboactive = true
var punchcombovar = 0
@onready var timer = $Timer
@onready var timer_2 = $Timer2
const player_bullet = preload("res://adventur of timtim/player_bullet.tscn")
@onready var animator = $AnimatedSprite2D
@onready var label = $Label

@export var SPEED = 100.0
@export var JUMP_VELOCITY = -280.0
const bullet = preload("res://adventur of timtim/bullet.tscn")
@onready var marker_2d = $Marker2D
var fires = false
@onready var canshoot = $canshoot
@onready var special_1 = $special1
@onready var special_2 = $specia2
const GLOBAL = preload("res://adventur of timtim/global.tscn")
@onready var special_1_area = $special1area
@onready var special_2_area = $special2area
@onready var special_1_col = $special1area/special1col
@onready var special_2_col = $special2area/specia2col
@onready var dodgestop = $dodgestop
@onready var youdiedanim = $Camera2D/AnimationPlayer
var havefire = true
var havespecial2 = true
var havespecial1 = true
var havebow = true
@onready var run = $run
@onready var walk = $walk
@onready var run_metal = $"run metal"

@onready var bowload = $bowload
@onready var bowsend = $bowsend

var inmove 
var speedrun = 500

@onready var fire_magic = $"fire magic"
@onready var firetime = $firetime
var decrease_rate := 0
var bull
var fire
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var moveactive = false
var havebullet = true
var shootactive = false
var bullet_count = 10
@onready var player_death = $"player death"
var health = 100
@onready var stop_anim = $"stop anim"
@onready var savespot_2 = $"../savespot2"
@onready var health_bar = $Camera2D/health_bar
@onready var blood = $blood
var mana := 100
var push_force = 80
var dodgeactive
var magic_active = false
var havemagic = true
var jumpactive = false
var is_key_pressed = false
var inputmanager = true
var idlecanrun = true
var bowdraw = false
@onready var collision_shape_2d_2 = $"bullet kill/CollisionShape2D2"
@onready var firesound = $fire

@onready var savespot = $"../savespot"

@onready var animation_player = $"../AnimationPlayer"

@onready var camera_2d = $player/Camera2D2

var soundactive = true
func _ready():

	special_1_col.disabled = true
	special_2_col.disabled = true
	collision_shape_2d_2.disabled = true
	firecol.disabled = true
	health = 60
	fires = false
	punchactive = true
	kickactive = true
	magic_active = true
	shootactive = true
	moveactive = true
	jumpactive = true
	dodgeactive = true
	k_ckallow.start()
	punchallow.start()
func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta
		kickactive = false
		dodgeactive = false
		punchactive = false
		magic_active = false
		shootactive = false
	if is_on_floor():
		kickactive = true
		punchactive = true
		dodgeactive = true
		magic_active = true
		shootactive = true
	deadf()
	shoot()
	move(delta)
	magic(delta)
	punch()
	_punchcombo()
	kick()
	jump()
	animation()
	_special1(delta)
	_special2(delta)
	sound()
	if health > 100:
		health = 100
	if health < 0:
		health = 0
	if mana < 0:
		mana = 0
	if mana > 100:
		mana = 100
	if inputmanager:
		is_key_pressed = false
		for key in keys_to_check:
			if Input.is_key_pressed(key):
				is_key_pressed = true
				break
		if is_key_pressed:
			idlecanrun = false
		else:
			idlecanrun = true
	if Input.is_action_just_pressed("run") and is_on_floor() and moveactive:
	
		SPEED = 200
		
	if Input.is_action_just_released("run") and is_on_floor() and moveactive:
		
		SPEED = 100

func jump():
	if jumpactive:
		if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY

func move(delta):
	if moveactive:
	
			
		

		
		var direction = Input.get_axis("left", "right")
		
		if direction:
			velocity.x = SPEED * direction
			inmove = true

	
			

		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			inmove = false
		
		
		if direction < 0:
			animator.flip_h = true
			right = false
			left = true
		if direction > 0:
			animator.flip_h = false
			left = false
			right = true
			

		if direction < 0:
			kickcol.position.x = -abs(kickcol.position.x)
		if direction > 0:
			kickcol.position.x = abs(kickcol.position.x)
			
		if direction < 0:
			punchcol.position.x = -abs(punchcol.position.x)
		if direction > 0:
			punchcol.position.x = abs(punchcol.position.x)
			
			
		if direction < 0:
			firecol.position.x = -abs(firecol.position.x)
		if direction > 0:
			firecol.position.x = abs(firecol.position.x)
		if direction < 0:
			special_1_col.position.x = -abs(special_1_col.position.x)
		if direction > 0:
			special_1_col.position.x = abs(special_1_col.position.x)
			
		if direction < 0:
			fire_magic.scale = -abs(fire_magic.scale)
		if direction > 0:
			fire_magic.scale = abs(fire_magic.scale)
			
			
		if direction < 0:
			special_1.scale = -abs(special_1.scale)
		if direction > 0:
			special_1.scale = abs(special_1.scale)
			
		if direction < 0:
			special_2.scale = -abs(special_2.scale)
		if direction > 0:
			special_2.scale = abs(special_2.scale)
			
		if direction < 0:
			marker_2d.position.x = -abs(marker_2d.position.x)
		if direction > 0:
			marker_2d.position.x = abs(marker_2d.position.x)
			
			
		move_and_slide()
	

		
func sound():
	if soundactive:




		if Input.is_action_just_pressed("magic") and magic_active and havefire:
			firesound.play()
		if Input.is_action_just_pressed("shoot") and shootactive and havebow and bullet_count > 0:
			bowload.play()
		if Input.is_action_just_released("shoot") and bullet_count > 0:
			bowsend.play()
		if Input.is_action_just_pressed("special1") and magic_active and havespecial1:
			firesound.play()
		if Input.is_action_just_pressed("special2") and magic_active and havespecial2:
			firesound.play()

		if Input.is_action_just_released("magic"):
			firesound.stop()
			
		if Input.is_action_just_released("special1"):
			firesound.stop()
		if Input.is_action_just_released("special2"):
			firesound.stop()
func animation():
	if animactive:
		var direction = Input.get_axis("left", "right")
		if is_on_floor() and idlecanrun == true:
			animator.play("idle")
		if direction < 0 and is_on_floor() and moveactive and SPEED ==100:
			animator.play("walk")
			
		if direction > 0 and is_on_floor() and moveactive and SPEED ==100:
				animator.play("walk")

		
		if direction < 0 and is_on_floor() and moveactive and SPEED ==200:
			animator.play("run")
		if direction > 0 and is_on_floor() and moveactive and SPEED ==200:
			animator.play("run")

		
		if Input.is_action_just_pressed("jump") and jumpactive:
			animator.play("jump_start")

		if Input.is_action_just_pressed("magic") and magic_active and havefire:
			animator.play("fire")
		if Input.is_action_just_pressed("shoot") and shootactive and havebow and bullet_count > 0:
			animator.play("draw")
		if Input.is_action_just_released("shoot") and bullet_count > 0:
			animator.play("shoot")
		if Input.is_action_just_pressed("special1") and magic_active and havespecial1:
			animator.play("fire")
		if Input.is_action_just_pressed("special2") and magic_active and havespecial2:
			animator.play("fire")
		if dead:
			animator.play("death")



func shoot():
	if shootactive and havebow:
		var direction = animator.flip_h
		if Input.is_action_just_pressed("shoot") and stopbow and bullet_count > 0:
			kickactive = false
			punchactive = false
			magic_active = false
			jumpactive = false
			moveactive = false
			dodgeactive = false
			bowdraw = true
			canshoot.start()
		if Input.is_action_just_released("shoot") and canshoot.is_stopped() and bullet_count > 0:
			collision_shape_2d_2.disabled = false
			inputmanager = false
			idlecanrun = false
			moveactive = true
			jumpactive = true
			magic_active = true
			punchactive = true
			kickactive = true
			dodgeactive = true
			havebullet = true
			idlecanreturnaftershoot.start()
			velocity.x = 0.1
			bull = player_bullet.instantiate()
			bull.init(direction)
			get_parent().add_child(bull)
			bull.global_position = marker_2d.global_position

			bullet_count -= 1
			
			stop_anim.start()
			bowdraw = false
		
	if bullet_count <= 0:
		bullet_count = 0
		stopbow = false
		if Input.is_action_just_pressed("shoot") and canshoot.is_stopped():
		
			havebullet = false
			shootactive = false
	else:
		stopbow = true
		havebullet = true
		shootactive = true

func magic(delta):
	if magic_active and havefire:
		firedamage = true
		var direction = animator.flip_h
		fire = fire_magic
		if Input.is_action_just_pressed("magic") and mana > 0:
			fires = true
			shootactive = false
			jumpactive = false
			moveactive = false
			punchactive = false
			dodgeactive = false
			kickactive = false
			firecol.disabled = false
			fire.emitting = true
			get_tree().current_scene.add_child(fire)
			fire.global_position = marker_2d.global_position

			stop_anim.start()
		if Input.is_action_just_released("magic"):
			fires = false
			firedamage = false
			fire.emitting = false

			jumpactive = true
			punchactive = true
			kickactive = true
			dodgeactive = true
			moveactive = true
			firecol.disabled = true
			shootactive = true
		if fires:
			mana -= decrease_rate * delta
		if mana == 0:
			firetime.start()
			fire_magic.emitting = false
			havemagic = false


func _special1(delta):
	if magic_active and havespecial1:
		special_1_area = true
		var direction = animator.flip_h
	
		if Input.is_action_just_pressed("special1") and mana > 0:
			fires = true
			shootactive = false
			jumpactive = false
			moveactive = false
			dodgeactive = false
			punchactive = false
			kickactive = false
			special_1_col.disabled = false
			special_1.emitting = true
			get_tree().current_scene.add_child(special_1)
			special_1.global_position = marker_2d.global_position

			stop_anim.start()
		if Input.is_action_just_released("special1"):
			fires = false
			firedamage = false
			special_1.emitting = false

			jumpactive = true
			punchactive = true
			dodgeactive = true
			kickactive = true
			moveactive = true
			special_1_col.disabled = true
			shootactive = true
		if fires:
			mana -= decrease_rate * delta
		if mana == 0:
			firetime.start()
			special_1.emitting = false
			havemagic = false

func _special2(delta):
	if magic_active and havespecial2:
		special_2_area = true
		var direction = animator.flip_h
	
		if Input.is_action_just_pressed("special2") and mana > 0:
			fires = true
			shootactive = false
			jumpactive = false
			moveactive = false
			punchactive = false
			dodgeactive = false
			kickactive = false
			special_2_col.disabled = false
			special_2.emitting = true
			get_tree().current_scene.add_child(special_2)
			special_2.global_position = marker_2d.global_position

			stop_anim.start()
		if Input.is_action_just_released("special2"):
			fires = false
			firedamage = false
			special_2.emitting = false

			jumpactive = true
			punchactive = true
			kickactive = true
			dodgeactive = true
			moveactive = true
			special_2_col.disabled = true
			shootactive = true
		if fires:
			mana -= decrease_rate * delta
		if mana == 0:
			firetime.start()
			special_2.emitting = false
			havemagic = false


			
func punch():

	if Input.is_action_just_pressed("punch") and is_on_floor():
		animactive = false
		velocity.x = 0.1
		moveactive = false
		magic_active = false
		dodgeactive = false
		inputmanager = false
		shootactive = false 
		jumpactive = false
		kickactive = false
		
		fire_magic.emitting = false
		special_1.emitting = false
		special_2.emitting = false
		animator.play("attack")
		punchnkick.play("punchcol")
		punchover.start()
		punchallow.start()
		
func kick():
	if Input.is_action_just_pressed("kick") and is_on_floor():
		animactive = false
		velocity.x = 0.1
		moveactive = false
		magic_active = false
		shootactive = false 
		dodgeactive = false
		inputmanager = false
		jumpactive = false
		punchactive = false
		
	
		fire_magic.emitting = false
		special_1.emitting = false
		special_2.emitting = false

		animator.play("kick")
		punchnkick.play("kickcol")
	


		kickover.start()
		k_ckallow.start()
		
	
func _punchcombo():
	if punchcomboactive:
		if Input.is_action_just_pressed("punch") and punchcombovar == 1:
			moveactive = false
			magic_active = false
			dodgeactive = false
			shootactive = false 
	
			punchactive = false
	
			punchover.start()
func _on_bullet_kill_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var _particle = blood
	_particle.rotation = -global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
	animation_player.play("camera hit")

	health  -= 10
	if health == 0:
		
		shootactive = false
		moveactive = false

		player_death.start()
	if health > 0:

		shootactive = false
		dodgeactive = false
		moveactive = false
	
		animation_player.play("camera hit")
		timer_2.start()
	
	
func _on_map_kill_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	timer.start()


func _on_timer_timeout():
	savespot.load_data()


func _on_timer_2_timeout():

	shootactive = true
	moveactive = true
	




func _on_player_death_timeout():
	savespot.load_data()


func _on_firetime_timeout():
	magic_active = false


func _on_punchover_timeout():
	animactive = true
	moveactive = true
	
	inputmanager = true
	jumpactive = true
func _on_punchcombo_timeout():
	punchcombovar = 0


func _on_kickover_timeout():
	animactive = true
	moveactive = true
	jumpactive = true
	inputmanager = true





func _on_canshoot_timeout():
	canshoot.stop()


func _on_idlecanreturnaftershoot_timeout():
	inputmanager = true







func _on_kİckallow_timeout():
	kickactive = true


func _on_punchallow_timeout():
	punchactive = true
func deadf():
	if health == 0:
		dead = true
		moveactive = false
		magic_active = false
		shootactive = false 
		dodgeactive = false
		inputmanager = false
		jumpactive = false
		punchactive = false
		idlecanrun = false
		_dead.start()





func _on_dead_timeout():
	dead = false
	youdiedanim.play("new_animation")
	_physics_process(false)


func _on_healthitemget_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	health += 10


func _on_manaitemget_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	mana += 20





func _on_havebow_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	havebow = true


func _on_havespecial_2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	havespecial2 = true


func _on_havespecial_1_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	havespecial1 = true


func _on_havefire_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	havefire = true


func _on_fragmentget_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	bullet_count += 3
