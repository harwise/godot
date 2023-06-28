extends Node2D

@export var columns: int = 10
#@export var rows: int = 10
var rng = RandomNumberGenerator.new()

var ballPos

# Called when the node enters the scene tree for the first time.
func _ready():
	ballPos = Vector2($nail_board.x_center, $nail_board.y_top - 50)
	print(ballPos)
	
	remove_child($ball)
	remove_child($nail)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var ball = load("res://ball.tscn").instantiate()
	ball.global_position = ballPos
	ball.global_position.x += rng.randf_range(-1., 1.)
	add_child(ball)
	pass # Replace with function body.
