extends CharacterBody2D
@onready var player = %player
@onready var label = $Label
@onready var arrowhitstop = $arrowhitstop

var health = 100
var playerdetectentered
var playerdetectexited
@export var speed = 40.0
var idleactive = true
var sawplayeractive = true
var attackactive = true
var gethitactive = false
var dieactive = true
var inidle = true
var insawplayer = false
@onready var gethitt = $gethit
@onready var dyingt = $dying
var dying = false
@onready var animator = $AnimatedSprite2D
@onready var leftsight = $leftsight
@onready var leftsidearea = $leftsight/leftsidearea
@onready var rightsight = $rightsight
@onready var rightsidearea = $rightsight/rightsidearea
var leftseen = false
var rightseen = false
@onready var playerdetect = $playerdetect
var inattack = false
@onready var attack_1_col = $attack1col
@onready var attack_2_col = $attack2col
@onready var animation_player = $AnimationPlayer
var random = [1, 2].pick_random()
@onready var attackover = $attackover
var attack1 = false
var attack2 = false
var burned = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var rightsidecol = $rightsight/rightsidearea/rightsidecol
@onready var leftsidecol = $leftsight/leftsidearea/leftsidecol
@onready var progress_bar = $ProgressBar
var ingethit = false
@onready var punchgethit = $punchgethit
@onready var kickgethit = $kickgethit
@onready var arrowgethit = $arrowgethit
@onready var firegethit = $firegethit
@onready var special_1_gethit = $special1gethit
@onready var special_2_gethit = $special2gethit
@onready var punchcol = $punchgethit/punchcol
@onready var kickcol = $kickgethit/kickcol
@onready var arrowcol = $arrowgethit/arrowcol
@onready var firecol = $firegethit/firecol
@onready var sep_1_col = $special1gethit/sep1col
@onready var sep_2_col = $special2gethit/sep2col





func _physics_process(delta):
	animation()
	if not is_on_floor():
		velocity.y += gravity * delta
	if idleactive:
		idle()
	elif sawplayeractive:
		sawplayer(delta)
	elif attackactive:
		attack()
	elif gethitactive:
		gethit()
	elif dieactive:
		die()
	if burned:
		health -= 20 * delta
	if health < 0:
		health = 0
	label.text = str (health)

	if health > 0:
		gethitt.start()
	if health == 0:
		inidle = false
		idleactive = false
		insawplayer = false
		sawplayeractive = false
		inattack = false
		attackactive = false
		ingethit = false
		gethitactive = false
		animator.play("die")
		dying = true
		dyingt.start()
func idle():
	if idleactive == true:
		attackactive = false
		sawplayeractive = false
		insawplayer = false
		inidle = true
		velocity.x = move_toward(velocity.x, 0, speed)
		move_and_slide()
	
func sawplayer(delta):
	if sawplayeractive:
		speed = 40
		if leftseen:
			animator.flip_h = true
			velocity.x =  -speed 
			move_and_slide()
		if animator.flip_h == true:
			attack_1_col.position.x = -abs(attack_1_col.position.x)
			attack_2_col.position.x = -abs(attack_2_col.position.x)

		if rightseen:
			animator.flip_h = false
			velocity.x =  speed 
			move_and_slide()
		if animator.flip_h == false:
			attack_1_col.position.x = abs(attack_1_col.position.x)
			attack_2_col.position.x = abs(attack_2_col.position.x)


func attack():
	
	if attackactive:
		if playerdetect:
			speed = 1
			
			if random == 1:
				attack1 = true
				animation_player.play("attack1col")
				attackover.start()
			if random == 2:
				attack2 = true
				animation_player.play("attack2col")
				attackover.start()
			
func gethit():
	if gethitactive:
		ingethit = true
		speed = 0
		
		gethitt.start()

			
			
func die():
	if dieactive:
		set_physics_process(false)
		animator.play("dead")
		leftsight.queue_free()
		rightsight.queue_free()
		playerdetect.queue_free()
		punchgethit.queue_free()
		kickgethit.queue_free()
		arrowgethit.queue_free()
		firegethit.queue_free()
		special_1_gethit.queue_free()
		special_2_gethit.queue_free()
func animation():
	if inidle:
		animator.play("idle")
	if insawplayer:
		animator.play("run")
	if attack1 and inattack:
		animator.play("attack")
	if attack2 and inattack:
		animator.play("attack2")
	if ingethit:
		animator.play("hurt")


func _on_leftsidearea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	speed = 40
	leftseen = true
	insawplayer = true
	sawplayeractive = true
	inidle = false
	idleactive = false
	attackactive = false

	
	

func _on_rightsidearea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	speed = 40
	rightseen = true
	insawplayer = true
	sawplayeractive = true
	inidle = false
	idleactive = false
	attackactive = false
func _on_rightsidearea_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	
	rightseen = false
	insawplayer = false
	idleactive = true
	inidle = true
	attackactive = false

func _on_leftsidearea_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	leftseen = false
	insawplayer = false
	idleactive = true
	inidle = true
	attackactive = false


func _on_playerdetect_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	playerdetectentered = true
	playerdetectexited = false

	insawplayer = false
	sawplayeractive = false
	inidle = false
	idleactive = false
	attackactive = true
	inattack = true
	attackactive = true
	
		

		




func _on_attackover_timeout():
	if playerdetectexited:
		insawplayer = true
		sawplayeractive = true
		inidle = false
		idleactive = false
		attackactive = false
		inattack = false
	if playerdetectentered:
		attack()


func _on_playerdetect_area_shape_exited(area_rid, area, area_shape_index, local_shape_index): 
	playerdetectexited = true
	playerdetectentered = false
	insawplayer = true
	sawplayeractive = true
	inidle = false
	idleactive = false
	attackactive = false
	inattack = false


func _on_punchgethit_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):

	health -= 10
	gethitactive = true

func _on_kickgethit_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	health -= 10
	gethitactive = true

func _on_arrowgethit_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	health -= 50

	leftseen = false
	insawplayer = false
	sawplayeractive = false
	inidle = false
	idleactive = false
	attackactive = false
	gethitactive = true
	ingethit = true
	arrowhitstop.start()
func _on_firegethit_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	burned = true
	gethitactive = true
	leftseen = false
	insawplayer = false
	sawplayeractive = false
	inidle = false
	idleactive = false
	attackactive = false
	gethitactive = true
	ingethit = true
func _on_firegethit_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	burned = false
	gethitactive = false
	if _on_leftsidearea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
		insawplayer = true
		sawplayeractive = true
	else:
		inidle = true
		idleactive = true
	if _on_rightsidearea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
		insawplayer = true
		sawplayeractive = true
	else:
		inidle = true
		idleactive = true
	ingethit = false
func _on_special_1_gethit_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	burned = true
	gethitactive = true
	leftseen = false
	insawplayer = false
	sawplayeractive = false
	inidle = false
	idleactive = false
	attackactive = false
	gethitactive = true
	ingethit = true
func _on_special_1_gethit_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	burned = false
	gethitactive = false
	if _on_leftsidearea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
		insawplayer = true
		sawplayeractive = true
	else:
		inidle = true
		idleactive = true
	if _on_rightsidearea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
		insawplayer = true
		sawplayeractive = true
	else:
		inidle = true
		idleactive = true
	ingethit = false
func _on_special_2_gethit_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	burned = true
	gethitactive = true
	leftseen = false
	insawplayer = false
	sawplayeractive = false
	inidle = false
	idleactive = false
	attackactive = false
	gethitactive = true
	ingethit = true
func _on_special_2_gethit_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	burned = false
	gethitactive = false
	if _on_leftsidearea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
		insawplayer = true
		sawplayeractive = true
	else:
		inidle = true
		idleactive = true
	if _on_rightsidearea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
		insawplayer = true
		sawplayeractive = true
	else:
		inidle = true
		idleactive = true
	ingethit = false

func _on_gethit_timeout():

		inidle = true
		idleactive = true
	
		ingethit = false
		gethitactive = false


func _on_dying_timeout():
	dieactive = true





func _on_arrowhitstop_timeout():
	ingethit = false
