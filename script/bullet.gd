extends Spatial

export var KILL_TIME = 2
var timer = 0

func _ready():
	set_physics_process(true);

func _physics_process(delta):
	timer += delta
	if timer > KILL_TIME:
		queue_free()
		timer = 0
