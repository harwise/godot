extends Area2D

var distance_x = 30
var distance_y = 30
var x_center = 0
var y_top = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var tl = $CollisionShape2D.position - $CollisionShape2D.shape.size / 2
	var br = tl + $CollisionShape2D.shape.size
	print(tl, br)
	for col in range($CollisionShape2D.shape.size.x / distance_x):
		for row in range($CollisionShape2D.shape.size.y / distance_y):
			var pos = tl + Vector2(col * distance_x, row * distance_y) 
			var nail = load("res://nail.tscn").instantiate()
			if (row % 2 == 0):
				pos.x += distance_x / 2
			nail.position = pos
			add_child(nail)
	var cc = ($CollisionShape2D.shape.size.x / distance_x) as int
	x_center = tl.x + cc / 2 * distance_x
	print(cc, x_center)
	y_top = tl.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
