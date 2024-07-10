extends Sprite2D

@export var speed = 10
var direction = false


func _ready():
	scale = Vector2(.001, .001)

func _physics_process(delta):
	if direction:
		position.x -= speed
	else:
		position.x += speed


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func init(d):
	direction = d
