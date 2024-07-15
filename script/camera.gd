extends Node

export (NodePath) var follow_this_path = null
export (NodePath) var camera_path = null
export (NodePath) var arrow_path = null
export (NodePath) var goal = null
export (NodePath) var efects = null
export var target_distance = 5.0
export var target_height = 1.0
export var delay = 50.0

var follow_this = null
var camera = null
var arrow = null
var go = null
var last_lookat
var init_v = Vector3(0.0, 0.0, 0.0)
var look_steer = 0.0
var sfx = null
var wait_sfx = 0

func _ready():
	follow_this = get_node(follow_this_path)
	camera = get_node(camera_path)
	last_lookat = follow_this.global_transform.origin
	arrow = get_node(arrow_path)
	go = get_node(goal)
	sfx = get_node(efects)

func _physics_process(delta):
	arrow.look_at(go.get_transform().origin, Vector3(0.0, 1.0, 0.0))
	var delta_v = camera.global_transform.origin - follow_this.global_transform.origin
	var target_pos = camera.global_transform.origin
	
	# ignore y
	delta_v.y = 0.0
	
	if (delta_v.length() > target_distance):
		delta_v = delta_v.normalized() * target_distance
		delta_v.y = target_height
		target_pos = follow_this.global_transform.origin + delta_v
	else:
		target_pos.y = follow_this.global_transform.origin.y + target_height
	
	camera.global_transform.origin = camera.global_transform.origin.linear_interpolate(target_pos, delta * delay)
	
	last_lookat = last_lookat.linear_interpolate(follow_this.global_transform.origin, delta * delay)

	var aceleration_absolute = storeAbsoluteAcceleration(follow_this, storeAcceleration(follow_this, delta))
	var look_step = aceleration_absolute / -250.0
	if (look_steer < (look_step - 0.005)):
		look_steer += 0.003
	elif (look_steer > (look_step + 0.005)):
		look_steer -= 0.003
	last_lookat.y += look_steer
	
	camera.look_at(last_lookat, Vector3(0.0, 1.0, 0.0))

	wait_sfx += delta
	var b = sfx.is_active()
	if((b == true and wait_sfx >= 3) or (b == false and wait_sfx >= 1)):
		var v = follow_this.get_velocity()
		var a = follow_this.get_angular_velocity()
		if(v > 70.0 or v < -70.0 or a > 3.0 or a < -3.0):
			if(b == false):
				sfx.active_sfx()
		elif(b == true):
			sfx.remove_sfx()
		wait_sfx = 0

func storeAcceleration(node, delta):
	var velocity = node.get_linear_velocity() #velociade
	var acceleration = (init_v - velocity) / delta #aceleracao
	init_v = velocity
	return acceleration


func storeAbsoluteAcceleration(node, acceleration):
	acceleration.x *= sin(node.get_rotation().y)
	acceleration.z *= cos(node.get_rotation().y)
	return (acceleration.x + acceleration.z)