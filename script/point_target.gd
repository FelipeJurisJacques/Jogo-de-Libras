extends Spatial

export (PackedScene) var cheking = null
export var distance_check = 2.0

export (NodePath) var element_Ag = null
export (NodePath) var element_Al = null
export (NodePath) var element_Ar = null
export (NodePath) var element_Au = null
export (NodePath) var element_C = null
export (NodePath) var element_Ca = null
export (NodePath) var element_Fe = null
export (NodePath) var element_H = null
export (NodePath) var element_He = null
export (NodePath) var element_K = null
export (NodePath) var element_Li = null
export (NodePath) var element_Mg = null
export (NodePath) var element_Na = null
export (NodePath) var element_Ne = null
export (NodePath) var element_generico = null

var Ag = null
var Al = null
var Ar = null
var Au = null
var C = null
var Ca = null
var Fe = null
var H = null
var He = null
var K = null
var Li = null
var Mg = null
var Na = null
var Ne = null
var default = null

var step = 0
var check = 0
var current = null
var pontos = 0

func _ready():
    check = load(cheking.get_path())
    Ag = get_node(element_Ag)
    Al = get_node(element_Al)
    Ar = get_node(element_Ar)
    Au = get_node(element_Au)
    C = get_node(element_C)
    Ca = get_node(element_Ca)
    Fe = get_node(element_Fe)
    H = get_node(element_H)
    He = get_node(element_He)
    K = get_node(element_K)
    Li = get_node(element_Li)
    Mg = get_node(element_Mg)
    Na = get_node(element_Na)
    Ne = get_node(element_Ne)
    default = get_node(element_generico)
    Ag.set_element_visible()
    current = Ag.get_nome()
    Al.set_element_invisible()
    Ar.set_element_invisible()
    Au.set_element_invisible()
    C.set_element_invisible()
    Ca.set_element_invisible()
    Fe.set_element_invisible()
    H.set_element_invisible()
    He.set_element_invisible()
    K.set_element_invisible()
    Li.set_element_invisible()
    Mg.set_element_invisible()
    Na.set_element_invisible()
    Ne.set_element_invisible()
    default.visible = false

func get_current():
    return current

func set_current(args):
    current = args

func checking(args):
    if(self.get_transform().origin.distance_to(args.get_transform().origin) < distance_check):
        return true
    else:
        return false

func next_element():
    Ag.set_element_invisible()
    Al.set_element_invisible()
    Ar.set_element_invisible()
    Au.set_element_invisible()
    C.set_element_invisible()
    Ca.set_element_invisible()
    Fe.set_element_invisible()
    H.set_element_invisible()
    He.set_element_invisible()
    K.set_element_invisible()
    Li.set_element_invisible()
    Mg.set_element_invisible()
    Na.set_element_invisible()
    Ne.set_element_invisible()
    # if(current ==  Ne.get_nome()):
    #     current = Ag.get_nome()
    #     Ag.set_element_visible()
    # elif(current ==  Ag.get_nome()):
    #     current = Al.get_nome()
    #     Al.set_element_visible()
    # elif(current ==  Al.get_nome()):
    #     current = Ar.get_nome()
    #     Ar.set_element_visible()
    # elif(current ==  Ar.get_nome()):
    #     current = Au.get_nome()
    #     Au.set_element_visible()
    # elif(current ==  Au.get_nome()):
    #     current = C.get_nome()
    #     C.set_element_visible()
    # elif(current ==  C.get_nome()):
    #     current = Ca.get_nome()
    #     Ca.set_element_visible()
    # elif(current ==  Ca.get_nome()):
    #     current = Fe.get_nome()
    #     Fe.set_element_visible()
    # elif(current ==  Fe.get_nome()):
    #     current = H.get_nome()
    #     H.set_element_visible()
    # elif(current ==  H.get_nome()):
    #     current = He.get_nome()
    #     He.set_element_visible()
    # elif(current ==  He.get_nome()):
    #     current = K.get_nome()
    #     K.set_element_visible()
    # elif(current ==  K.get_nome()):
    #     current = Li.get_nome()
    #     Li.set_element_visible()
    # elif(current ==  Li.get_nome()):
    #     current = Mg.get_nome()
    #     Mg.set_element_visible()
    # elif(current ==  Mg.get_nome()):
    #     current = Na.get_nome()
    #     Na.set_element_visible()
    # elif(current ==  Na.get_nome()):
    #     current = Ne.get_nome()
    #     Ne.set_element_visible()
    # else:
    #     default.visible = true
    #     current = null
    # return null
    if(current ==  Ne.get_nome()):
        current = Ag.get_nome()
        Ag.set_element_visible()
    elif(current ==  Ag.get_nome()):
        current = Al.get_nome()
        Al.set_element_visible()
    elif(current ==  Al.get_nome()):
        current = Ar.get_nome()
        Ar.set_element_visible()
    elif(current ==  Ar.get_nome()):
        current = Au.get_nome()
        Au.set_element_visible()
    elif(current ==  Au.get_nome()):
        current = C.get_nome()
        C.set_element_visible()
    elif(current ==  C.get_nome()):
        current = Ca.get_nome()
        Ca.set_element_visible()
    elif(current ==  Ca.get_nome()):
        current = He.get_nome()
        He.set_element_visible()
    elif(current ==  He.get_nome()):
        current = K.get_nome()
        K.set_element_visible()
    elif(current ==  K.get_nome()):
        current = Mg.get_nome()
        Mg.set_element_visible()
    elif(current ==  Mg.get_nome()):
        current = Ne.get_nome()
        Ne.set_element_visible()
    else:
        default.visible = true
        current = null
    return null

func get_current_element():
    if(current ==  Ne.get_nome()):
        return Ne
    elif(current ==  Ag.get_nome()):
        return Ag
    elif(current ==  Al.get_nome()):
        return Al
    elif(current ==  Ar.get_nome()):
        return Ar
    elif(current ==  Au.get_nome()):
        return Au
    elif(current ==  C.get_nome()):
        return C
    elif(current ==  Ca.get_nome()):
        return Ca
    elif(current ==  Fe.get_nome()):
        return Fe
    elif(current ==  H.get_nome()):
        return H
    elif(current ==  He.get_nome()):
        return He
    elif(current ==  K.get_nome()):
        return K
    elif(current ==  Li.get_nome()):
        return Li
    elif(current ==  Mg.get_nome()):
        return Mg
    elif(current ==  Na.get_nome()):
        return Na
    return null

func default_element():
    Ag.set_element_invisible()
    Al.set_element_invisible()
    Ar.set_element_invisible()
    Au.set_element_invisible()
    C.set_element_invisible()
    Ca.set_element_invisible()
    Fe.set_element_invisible()
    H.set_element_invisible()
    He.set_element_invisible()
    K.set_element_invisible()
    Li.set_element_invisible()
    Mg.set_element_invisible()
    Na.set_element_invisible()
    Ne.set_element_invisible()
    default.visible = true

func get_pontos():
    return pontos
		
func respaw_point():
    var c = check.instance()
    self.get_tree().root.add_child(c)
    c.global_transform = self.global_transform
    if(step == 0):
        self.global_transform.origin = Vector3(5.0, 0.0, 0.0)
    else:
        if(step == 1):
            self.global_transform.origin = Vector3(130.0, 0.0, 25.0)
        else:
            if(step == 2):
                self.global_transform.origin = Vector3(-130.0, 0.0, 78.0)
            else:
                if(step == 3):
                    self.global_transform.origin = Vector3(26.0, 0.0, -25.0)
                else:
                    if(step == 4):
                        self.global_transform.origin = Vector3(-180.0, 0.0, 146.0)
                    else:
                        if(step == 5):
                            self.global_transform.origin = Vector3(70.0, 0.0, -100.0)
                        else:
                            if(step == 6):
                                self.global_transform.origin = Vector3(36.0, 0.0, 96.0)
                            else:
                                if(step == 7):
                                    self.global_transform.origin = Vector3(-107.0, 0.0, 39.0)
                                else:
                                    if(step == 7):
                                        self.global_transform.origin = Vector3(180.0, 0.0, 170.0)
                                    else:
                                        if(step == 8):
                                            self.global_transform.origin = Vector3(49.0, 0.0, -37.0)
                                        else:
                                            if(step == 9):
                                                self.global_transform.origin = Vector3(53.0, 0.0, 127.0)

    step += 1
    if(step >= 10):
        step = 0
    var d = check.instance()
    self.get_tree().root.add_child(d)
    d.global_transform = self.global_transform
    pontos += 1