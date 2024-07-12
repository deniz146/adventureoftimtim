extends Control
var progress = []
var sceneName
var scene_load_status = 0
@onready var label = $Label
@onready var texture_progress_bar = $TextureProgressBar
@onready var fire_1 = $fire1
@onready var fire_2 = $fire2
@onready var fire_3 = $fire3
var scenepath : String
# Called when the node enters the scene tree for the first time.
func _ready():
	scenepath = Loader.scenepath
	sceneName = scenepath
	ResourceLoader.load_threaded_request(sceneName)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(sceneName,progress)
	
	texture_progress_bar.value = progress[0] * 100
	if progress[0] * 0:
		fire_1.emitting = true
		
	if progress[0] * 30:
		fire_2.emitting = true
		
	if progress[0] * 60:
		fire_3.emitting = true
		
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene = ResourceLoader.load_threaded_get(sceneName)
		get_tree().change_scene_to_packed(newScene)
