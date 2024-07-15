extends VehicleBody

export (NodePath) var wheel_f_l = null
export (NodePath) var wheel_f_r = null
export (NodePath) var wheel_r_l = null
export (NodePath) var wheel_r_r = null

export var MAX_ENGINE_FORCE = 200.0
export var MAX_BRAKE_FORCE = 5.0
export var MAX_STEER_ANGLE = 0.5

export var steer_speed = 5.0

export var joy_steering = JOY_ANALOG_LX
export var steering_mult = -1.0
export var joy_throttle = JOY_ANALOG_R2
export var throttle_mult = 1.0
export var joy_brake = JOY_ANALOG_L2
export var brake_mult = 1.0

var steer_target = 0.0
var steer_angle = 0.0

var w_f_l = null
var w_f_r = null
var w_r_l = null
var w_r_r = null

export (NodePath) var weapon = null
export (NodePath) var particle = null
export (PackedScene) var munition = null
var gun = null
var bullet = null
var fire = null

var timer = 0
var gun_speed = 0.0
var shot_delay = 0

var velocity = 0.0

func _ready():
	w_f_l = get_node(wheel_f_l)
	w_f_r = get_node(wheel_f_r)
	w_r_l = get_node(wheel_r_l)
	w_r_r = get_node(wheel_r_r)
	gun = get_node(weapon)
	fire = get_node(particle)
	bullet = load(munition.get_path())

func _physics_process(delta):
	var steer_val = steering_mult * Input.get_joy_axis(0, joy_steering)
	var throttle_val = throttle_mult * Input.get_joy_axis(0, joy_throttle)
	var brake_val = brake_mult * Input.get_joy_axis(0, joy_brake)

	velocity = storeAbsoluteVelocity(self)
	
	# overrules for keyboard
	if Input.is_action_pressed("ui_up"):
		if(velocity >= -0.1):
			throttle_val = 1.0
		else:
			brake_val = 1.0
	if Input.is_action_pressed("ui_down"):
		if(velocity <= 0.1):
			throttle_val = -1.0
		else:
			brake_val = 1.0

	if Input.is_action_pressed("ui_left"):
		steer_val = 1.0
	elif Input.is_action_pressed("ui_right"):
		steer_val = -1.0
	
	if Input.is_action_pressed("ui_select"):
		brake_val = 1.0
		if(velocity > 10.0):
			var angle = self.angular_velocity
			angle.y = steer_angle
			self.set_angular_velocity(angle)
	
	engine_force = throttle_val * MAX_ENGINE_FORCE
	brake = brake_val * MAX_BRAKE_FORCE
	
	steer_target = steer_val * MAX_STEER_ANGLE
	if (steer_target < steer_angle):
		steer_angle -= steer_speed * delta
		if (steer_target > steer_angle):
			steer_angle = steer_target
	elif (steer_target > steer_angle):
		steer_angle += steer_speed * delta
		if (steer_target < steer_angle):
			steer_angle = steer_target
	
	steering = steer_angle

	autoFlip(self, delta)
	weapon(self, delta)

func storeAbsoluteVelocity(node):
	var v = node.get_linear_velocity()
	v.x *= sin(node.get_rotation().y)
	v.z *= cos(node.get_rotation().y)
	return (v.x + v.z)

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

func weapon(car, delta):
	if Input.is_action_pressed("ui_accept"):
		if(gun_speed >= 0.7):
			if(shot_delay >= 3):
				var shot = bullet.instance()
				gun.get_tree().root.add_child(shot)
				shot.global_transform = gun.global_transform
				shot.linear_velocity = shot.global_transform.basis.z * 200
				shot_delay = 0
				fire.visible = true
			else:
				shot_delay += 1
		else:
			fire.visible = false
			gun_speed += 0.1
	else:
		if(gun_speed <= 0.0):
			gun_speed = 0.0
		else:
			fire.visible = false
			gun_speed -= 0.01
	gun.rotation.z += gun_speed

func get_velocity():
	return velocity

func get_angular_velocity():
	var v = self.angular_velocity
	return v.x + v.y + v.z