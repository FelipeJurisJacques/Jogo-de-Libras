extends Node2D

export (NodePath) var videoplayer = null

export (VideoStreamTheora) var clip_tutorial1 = null
export (VideoStreamTheora) var clip_tutorial2 = null
export (VideoStreamTheora) var clip_tutorial3 = null
export (VideoStreamTheora) var clip_Ag = null
export (VideoStreamTheora) var clip_Al = null
export (VideoStreamTheora) var clip_Ar = null
export (VideoStreamTheora) var clip_Au = null
export (VideoStreamTheora) var clip_C = null
export (VideoStreamTheora) var clip_Ca = null
export (VideoStreamTheora) var clip_Fe = null
export (VideoStreamTheora) var clip_H = null
export (VideoStreamTheora) var clip_He = null
export (VideoStreamTheora) var clip_K = null
export (VideoStreamTheora) var clip_Li = null
export (VideoStreamTheora) var clip_Mg = null
export (VideoStreamTheora) var clip_Na = null
export (VideoStreamTheora) var clip_Ne = null

var video = null
var clip = false

func _ready():
    video = get_node(videoplayer)

func _physics_process(delta):
    if(video.get_stream_name() == '<No Stream>' and clip == true):
        self.visible = false
    elif(not video.is_playing() or video.is_paused()):
        self.visible = false
    else:
        self.visible = true

func play_tutorial():
    if(video.get_stream_name() != '<No Stream>' and clip == true):
        if(not video.is_playing()):
            video.play()

func pause_tutorial():
    if(video.is_playing()):
        if(not video.is_paused()):
            video.set_paused(true)

func unpause_tutorial():
    if(video.is_playing()):
        if(video.is_paused()):
            video.set_paused(false)

func stop_tutorial():
    if(video.is_playing()):
        video.stop()
    clip = false

func is_playing():
    return video.is_playing()

func play_clip(args):
    if(not video.is_playing() and args != null):
        if(args == 'tutorial1'):
            video.set_stream(clip_tutorial1)
            clip = true
        elif(args == 'tutorial2'):
            video.set_stream(clip_tutorial2)
            clip = true
        elif(args == 'tutorial3'):
            video.set_stream(clip_tutorial3)
            clip = true
        elif(args == 'Ag'):
            video.set_stream(clip_Ag)
            clip = true
        elif(args == 'Al'):
            video.set_stream(clip_Al)
            clip = true
        elif(args == 'Ar'):
            video.set_stream(clip_Ar)
            clip = true
        elif(args == 'Au'):
            video.set_stream(clip_Au)
            clip = true
        elif(args == 'C'):
            video.set_stream(clip_C)
            clip = true
        elif(args == 'Ca'):
            video.set_stream(clip_Ca)
            clip = true
        elif(args == 'Fe'):
            video.set_stream(clip_Fe)
            clip = true
        elif(args == 'H'):
            video.set_stream(clip_H)
            clip = true
        elif(args == 'He'):
            video.set_stream(clip_He)
            clip = true
        elif(args == 'K'):
            video.set_stream(clip_K)
            clip = true
        elif(args == 'Li'):
            video.set_stream(clip_Li)
            clip = true
        elif(args == 'Mg'):
            video.set_stream(clip_Mg)
            clip = true
        elif(args == 'Na'):
            video.set_stream(clip_Na)
            clip = true
        elif(args == 'Ne'):
            video.set_stream(clip_Ne)
            clip = true
        else:
            clip = false
        video.play()