extends Spatial

export var delay = 1.0

func _physics_process(delta):
    self.rotation.y += delta * delay