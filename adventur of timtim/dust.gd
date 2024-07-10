extends GPUParticles2D
@onready var dust = $"."
func _ready():
	dust.emitting = true
