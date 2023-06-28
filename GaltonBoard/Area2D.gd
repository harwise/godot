extends Area2D

@export var columns: int

# Called when the node enters the scene tree for the first time.
func _ready():
	columns = get_node("/root/Node2D").columns


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	#print("xxxxxxxxxx")
	#print(body.global_position)
	#print(global_position)
	#print($CollisionShape2D.global_position)
	
	var a = body.global_position.x - (global_position.x - $CollisionShape2D.shape.size.x/2)
	var index = (a / $CollisionShape2D.shape.size.x) * columns
	print(a)
	print(index)
	get_node("/root/Node2D/hist").Update(index as int, 1)
	body.get_parent().remove_child(body)
	body.queue_free()
