extends StaticBody2D

var rng = RandomNumberGenerator.new()
var time_count_down = 0
var init_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	init_pos = position # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	time_count_down -= delta
	if time_count_down < 0:
		rng.randomize()
		var offset = rng.randf()
		if (position.x - init_pos.x > 0):
			position.x -= offset
		else:
			position.x += offset
		time_count_down = rng.randf()
	pass	
