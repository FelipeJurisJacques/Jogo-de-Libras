extends VehicleBody
export (NodePath) var follow = null
export (NodePath) var target = null

export var MAX_ENGINE_FORCE = 200.0
export var MAX_BRAKE_FORCE = 5.0
export var MAX_STEER_ANGLE = 0.5

export var steer_speed = 5.0

var steer_target = 0.0
var steer_angle = 0.0

var follow_this = null
var target_this = null

var timer = 0
var timer2 = 0
var m = false

func _ready():
	follow_this = get_node(follow)
	target_this = get_node(target)

func _physics_process(delta):
	# var distance = (follow_this.get_transform().origin - self.get_transform().origin).length() #distancia
	# var this_angle = self.get_rotation().y #angulo atual
	target_this.look_at(follow_this.get_transform().origin, Vector3(0.0, 1.0, 0.0))
	var target_angle = target_this.get_rotation().y + PI
	if(target_angle > PI):
		target_angle -= 2 * PI

	var steer_val = 0
	var throttle_val = 0
	var brake_val = 0
	var velocity = storeAbsoluteVelocity(self)

	#realiza manobra
	if(m == false):
		if(velocity <= 3.0):
			timer2 += delta
			if(timer2 > 2):
				timer2 = 0
				m = true
		else:
			timer2 = 0

	if(m == true):
		timer2 += delta
		throttle_val = -0.5
		if(timer2 > 3):
			timer2 = 0
			m = false
	else:
		throttle_val = 1.0

		#suavilisa velocidade em curva
		if(velocity > 10.0):
			if(target_angle > (PI / 4) || target_angle < (PI / -4)):
				throttle_val = 0.0
		if(velocity > 30.0):
			if(target_angle > (PI / 8) || target_angle < (PI / -8)):
				throttle_val = 0.0
				brake_val = 1.0

	steer_val = target_angle * 5.0
	if (steer_val > 1.0):
		steer_val = 1.0
	elif (steer_val < -1.0):
		steer_val = -1.0
		
	steer_target = steer_val * MAX_STEER_ANGLE
	if (steer_target < steer_angle):
		steer_angle -= steer_speed * delta
		if (steer_target > steer_angle):
			steer_angle = steer_target
	elif (steer_target > steer_angle):
		steer_angle += steer_speed * delta
		if (steer_target < steer_angle):
			steer_angle = steer_target
		
	engine_force = throttle_val * MAX_ENGINE_FORCE
	brake = brake_val * MAX_BRAKE_FORCE
	steering = steer_angle

	autoFlip(self, delta)

func storeAbsoluteVelocity(node):
	var velocity = node.get_linear_velocity()
	velocity.x *= sin(node.get_rotation().y)
	velocity.z *= cos(node.get_rotation().y)
	return (velocity.x + velocity.z)

func autoFlip(car, delta):
	var rotation = car.get_rotation()
	var pos = car.global_transform.origin
	if(rotation.z < -1 or rotation.z > 1):
		timer += delta
		if(timer > 3):
			rotation.z = 0.0
			rotation.x = 0.0
			car.set_rotation(rotation)
			car.set_linear_velocity(Vector3(0.0, 0.0, 0.0))
			car.set_angular_velocity(Vector3(0.0, 0.0, 0.0))
			pos.y += 1.0
			car.global_transform.origin = pos
			timer = 0
	else:
		timer = 0
	if(pos.y < -0.5):
		pos.y = 3.0
		car.global_transform.origin = pos