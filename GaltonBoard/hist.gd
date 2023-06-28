extends Control

@export var bars: int = 3

var values = []
var valuesf = []
var maxf = 0.0

func Update(bar, value):
	values[bar] += value
	print(values)
	var sum: float = 0
	maxf = 0.0
	for v in values:
		sum += v
	for i in range(bars):
		valuesf[i] = values[i] / sum
		if (valuesf[i] > maxf):
			maxf = valuesf[i]
	queue_redraw()

# Called when the node enters the scene tree for the first time.
func _ready():
	bars = get_node("/root/Node2D").columns
	values.resize(bars)
	values.fill(0)
	valuesf.resize(bars)
	valuesf.fill(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Update(0, 1)
	pass


func _draw():
	#draw_rect(Rect2(Vector2(0,0), Vector2(50,50)), Color("red"), false, 5)
	var r = get_rect()
	#print(r.position)
	#print(r.size)
	#print(position)
	#print("-------------")
	var barSize = Vector2(r.size.x / bars, r.size.y);
	for i in range(bars):
		var lt = Vector2(r.size.x * i / bars, 0)
		draw_rect(Rect2(lt, barSize), Color("red"), false, 5)
		var lt2 = lt;
		lt2.y += (1 - valuesf[i] / maxf) * r.size.y
		draw_rect(Rect2(lt2, barSize), Color("blue"))
