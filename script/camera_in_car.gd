extends Camera

export (NodePath) var follow = null
export var target_distance = 5.0
export var target_height = 1.0
export var target_acceleration_step = 0.02
export var look_steer_step = 0.03
export var look_steer_max = 2.0

var follow_this = null
var init_v = Vector3(0.0, 0.0, 0.0)
var distance_steer = 0.0
var look_steer = 0.0

func _ready():
	follow_this = get_node(follow)

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		if (look_steer < 0.0):
			look_steer += look_steer_step * 3.0
		if (look_steer < look_steer_max):
			look_steer += look_steer_step
	elif Input.is_action_pressed("ui_right"):
		if (look_steer > 0.0):
			look_steer -= look_steer_step * 3.0
		if (look_steer > (look_steer_max * -1.0)):
			look_steer -= look_steer_step
	else:
		if (look_steer > look_steer_step):
			look_steer -= look_steer_step
		elif (look_steer < (look_steer_step * -1.0)):
			look_steer += look_steer_step

	var distance_step = (storeAbsoluteAcceleration(follow_this, storeAcceleration(follow_this, delta)) / 30.0)
	if (distance_steer < (distance_step - 0.05)):
		distance_steer += target_acceleration_step
	elif (distance_steer > (distance_step + 0.05)):
		distance_steer -= target_acceleration_step

	var cam_pos = Vector3()
	cam_pos.x = look_steer
	cam_pos.y = target_height
	cam_pos.z = (target_distance * -1.0) + distance_steer
	cam_pos = storePositionTo(follow_this, cam_pos)

	global_transform.origin = cam_pos
	look_at(storePositionTo(follow_this, Vector3(0.0, 0.0, 0.0)), Vector3(0.0, 1.0, 0.0))

func storePositionTo(node, vector):
	var rotation = node.get_rotation() #rotacao
	var z_sin = sin(rotation.y) #seno relativo ao eixo z
	var z_cos = cos(rotation.y) #cosseno relativo ao eixo z
	var x_sin = sin(rotation.y + (PI / 2)) #seno relativo ao eixo x
	var x_cos = cos(rotation.y + (PI / 2)) #cosseno relativo ao eixo x
	var position = node.transform.origin
	position.x += x_sin * vector.x
	position.z += x_cos * vector.x
	position.x += z_sin * vector.z
	position.z += z_cos * vector.z
	position.y += vector.y
	return position

func storeAcceleration(node, delta):
	var velocity = node.get_linear_velocity() #velociade
	var acceleration = (init_v - velocity) / delta #aceleracao
	init_v = velocity
	return acceleration


func storeAbsoluteAcceleration(node, acceleration):
	acceleration.x *= sin(node.get_rotation().y)
	acceleration.z *= cos(node.get_rotation().y)
	return (acceleration.x + acceleration.z)