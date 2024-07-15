extends VideoPlayer

var time = 0.0

func _ready():
    time = 0.0

func _physics_process(delta):
    time += delta

    if(time > 3):
        if(self.is_playing() == false):
            self.play()