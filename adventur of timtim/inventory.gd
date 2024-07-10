extends Sprite2D
@onready var bullet_case = $"bullet case"
@onready var bullet_case_2 = $"bullet case2"
@onready var bullet_case_3 = $"bullet case3"
@onready var bullet_case_4 = $"bullet case4"
@onready var special_2 = $special2
@onready var special_1 = $special1
@onready var fire = $fire
@onready var bow = $bow
@onready var player = %player
@onready var label = $bow/Label

func _ready():
	bullet_case.hide()
	bullet_case_2.hide()
	bullet_case_3.hide()
	bullet_case_4.hide()
	special_1.hide()
	special_2.hide()
	fire.hide()
	bow.hide()
	label.hide()
func _process(delta):
	label.text = str (player.bullet_count)
	if player.havebow:
		bullet_case.show()
		bow.show()
		label.show()
	if player.havefire:
		bullet_case_2.show()
		fire.show()
	if player.havespecial1:
		bullet_case_3.show()
		special_1.show()
	if player.havespecial2:
		bullet_case_4.show()
		special_2.show()

