extends Node2D

export (NodePath) var menu_itens = null
export (NodePath) var menu_tutorial = null
export (NodePath) var menu_videoplayer = null

var itens = null
var tutorial = null
var video = null

var main_menu = true
var tutorial_clip = false

func _ready():
	itens = get_node(menu_itens)
	tutorial = get_node(menu_tutorial)
	video = get_node(menu_videoplayer)

func _physics_process(delta):
    if(main_menu == true):
        if(tutorial_clip == false):
            self.visible = true
            itens.visible = true
            tutorial.visible = false
            if(video.is_playing()):
                video.stop()
        else:
            main_menu = true
            self.visible = true
            itens.visible = false
            tutorial.visible = true
            if(not video.is_playing()):
                video.play()
    else:
        self.visible = false
        itens.visible = true
        tutorial.visible = false
        if(video.is_playing()):
            video.stop()
    
func is_in():
    return main_menu

func _on_voltar_pressed():
    to_menu()

func _on_jogar_pressed():
    to_clip()
    tutorial.play_clip('tutorial3')

func _on_combate_pressed():
    to_clip()
    tutorial.play_clip('tutorial2')

func _on_dirigir_pressed():
    to_clip()
    tutorial.play_clip('tutorial1')

func play_clip(args):
    if(args != null):
        to_clip()
        tutorial.play_clip(args)

func to_clip():
    main_menu = true
    tutorial_clip = true

func to_menu():
    main_menu = true
    tutorial_clip = false

func exit_menu():
    main_menu = false
    tutorial_clip = false