extends Spatial

export (PackedScene) var efects = null

var sfx = null
var instance = null

func _ready():
    sfx = load(efects.get_path())
    
func active_sfx():
    if(instance == null):
        instance = sfx.instance()
        self.add_child(instance)
        instance.transform.origin = Vector3(0.0, 0.0, 0.0)
        instance.rotation = Vector3(0.0, 0.0, 0.0)

func remove_sfx():
    if(instance != null):
        instance.queue_free()
        instance = null

func is_active():
    if(instance == null):
        return false
    else:
        return true