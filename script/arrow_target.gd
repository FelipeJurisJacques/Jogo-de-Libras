export (NodePath) var follow_this_path = null

var follow_this = null

func _ready():
	follow_this = get_node(follow_this_path)

func _physics_process(delta):
	self.look_at(follow_this.get_transform().origin, Vector3(0.0, 1.0, 0.0))