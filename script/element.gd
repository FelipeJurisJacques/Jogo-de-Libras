extends Spatial

export var elemento = ''
# export (VideoStreamTheora) var clip = null

func get_nome():
    return elemento

# func get_clip():
#     return clip

func set_element_visible():
    self.visible = true

func set_element_invisible():
    self.visible = false