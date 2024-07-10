extends GPUParticles2D
@onready var gpu_particles_2d = $"."
func _ready():
	gpu_particles_2d.emitting = true
