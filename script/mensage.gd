extends Node2D

export (NodePath) var videoplayer = null

export (VideoStreamTheora) var clip_inicio = null
export (VideoStreamTheora) var clip_objetivo = null
export (VideoStreamTheora) var clip_alerta1 = null
export (VideoStreamTheora) var clip_alerta2 = null
export (VideoStreamTheora) var clip_alerta3 = null
export (VideoStreamTheora) var clip_parado1 = null
export (VideoStreamTheora) var clip_parado2 = null
export (VideoStreamTheora) var clip_parado3 = null
export (VideoStreamTheora) var clip_rapido1 = null
export (VideoStreamTheora) var clip_fim = null

export (NodePath) var video_area = null
export (NodePath) var texture_fim = null

var video = null
var clip = false
var v_area = null
var fim = null

func _ready():
    video = get_node(videoplayer)
    v_area = get_node(video_area)
    fim = get_node(texture_fim)
    fim.visible = false

func _physics_process(delta):
    if(video.get_stream_name() == '<No Stream>' and clip == true):
        v_area.visible = false
    elif(not video.is_playing() or video.is_paused()):
        v_area.visible = false
    else:
        v_area.visible = true

func play_mensage():
    if(video.get_stream_name() != '<No Stream>' and clip == true):
        if(not video.is_playing()):
            video.play()

func pause_mensage():
    if(video.is_playing()):
        if(not video.is_paused()):
            video.set_paused(true)

func unpause_mensage():
    if(video.is_playing()):
        if(video.is_paused()):
            video.set_paused(false)

func stop_mensage():
    if(video.is_playing()):
        video.stop()
    clip = false

func is_playing():
    return video.is_playing()

func play_clip(args):
    if(not video.is_playing()):
        if(args == 'inicio'):
            video.set_stream(clip_inicio)
            clip = true
        elif(args == 'objetivo'):
            video.set_stream(clip_objetivo)
            clip = true
        elif(args == 'alerta1'):
            video.set_stream(clip_alerta1)
            clip = true
        elif(args == 'alerta2'):
            video.set_stream(clip_alerta2)
            clip = true
        elif(args == 'alerta3'):
            video.set_stream(clip_alerta3)
            clip = true
        elif(args == 'parado1'):
            video.set_stream(clip_parado1)
            clip = true
        elif(args == 'parado2'):
            video.set_stream(clip_parado2)
            clip = true
        elif(args == 'parado3'):
            video.set_stream(clip_parado3)
            clip = true
        elif(args == 'rapido1'):
            video.set_stream(clip_rapido1)
            clip = true
        elif(args == 'fim'):
            video.set_stream(clip_fim)
            fim.visible = true
            clip = true
        else:
            clip = false
        video.play()