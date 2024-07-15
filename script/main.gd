extends Node

export (NodePath) var arena = null
export (NodePath) var main_menu = null
export (NodePath) var main_mensage = null
export (NodePath) var player = null
export (NodePath) var mission_target = null

var cene = null
var menu = null
var mensage = null
var player_one = null
var mis_target = null

var time = 0
var inicio = false
var instrucao = false
var parado = 0.0
var parado_n = 1
var rapido = 0.0
var alerta = 0.0
var alerta_n = 1
var intervalo = 0.0
var enable_clip = true

func _ready():
	cene = get_node(arena)
	menu = get_node(main_menu)
	mensage = get_node(main_mensage)
	player_one = get_node(player)
	mis_target = get_node(mission_target)

	cene.get_tree().set_pause(true)
	mensage.play_clip('inicio')

func _physics_process(delta):
	# MENSAGENS
	if(menu.is_in() == false):
		mensage.unpause_mensage()

		# INICIO
		if(inicio == false):
			time += delta
			if(time >= 5.125):
				play_game()
				inicio = true
				time = 0
			elif(is_paused() == false):
				pause_game()

		# INSTRUCAO
		elif(instrucao == false):
			time += delta
			if(time >= 2.0):
				mensage.play_clip('objetivo')
				instrucao = true
				time = 0

		if(mensage.is_playing() == false):
			intervalo += delta
			if(intervalo > 7.0):
				# PARADO
				if(player_one.get_velocity() < 10.0 and player_one.get_velocity() > -10.0):
					parado += delta
					if(parado >= 4.0):
						if(parado_n == 1):
							mensage.play_clip('parado1')
							parado_n = 2
						elif(parado_n == 2):
							mensage.play_clip('parado2')
							parado_n = 3
						elif(parado_n == 3):
							mensage.play_clip('parado3')
							parado_n = 1
						parado = 0.0
				else:
					parado = 0.0

				# RAPIDO
				if(player_one.get_velocity() > 70.0 or player_one.get_velocity() < -70.0):
					rapido += delta
					if(rapido >= 3.0):
						mensage.play_clip('rapido1')
						rapido = 0.0
				else:
					rapido = 0.0

				# ALERTA
				if(player_one.get_angular_velocity() > 2.0 or player_one.get_angular_velocity() < -2.0):
					alerta += delta
					if(alerta >= 1.5):
						if(alerta_n == 1):
							mensage.play_clip('alerta1')
							alerta_n = 2
						elif(alerta_n == 2):
							mensage.play_clip('alerta2')
							alerta_n = 3
						elif(alerta_n == 3):
							mensage.play_clip('alerta3')
							alerta_n = 1
						alerta = 0.0
				else:
					alerta = 0.0
		else:
			intervalo = 0.0
			
	# PAUSA MENSAGEM
	else:
		mensage.pause_mensage()
					
	# CHEKINPOINT
	if(mis_target.checking(player_one) == true):
		mis_target.respaw_point()
		if(enable_clip == true):
			pause_game()
			menu.play_clip(mis_target.get_current())
			if(mis_target.get_pontos() > 14):
				mis_target.default_element()
				enable_clip = false
				mensage.stop_mensage()
				mensage.play_clip('fim')
				intervalo = 0.0
			else:
				mis_target.next_element()

func _input(ev):
	if Input.is_action_pressed("ui_cancel"):
		if(menu.is_in() == false):
			menu.to_menu()
			pause_game()
		else:
			menu.exit_menu()
			play_game()

func pause_game():
	cene.get_tree().set_pause(true)

func play_game():
	cene.get_tree().set_pause(false)

func is_paused():
	return cene.get_tree().paused
